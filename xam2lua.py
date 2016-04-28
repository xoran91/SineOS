import re

RECTANGLE_SIGNATURE = 'Margin Width Height Color'.split(' ')
f = open('xaml.txt','r')
compiled_f = ''
code = f.read().replace('\n','')
while(len(code) != 0):
    string = re.search('<[^<>]+>', code).group(0)
    compiled_class = re.search('<(\w+)\s', string).group(1)
    compiled_name = re.search('x:Name="(\S*)"', string).group(1)
    compiled_params = ''
    for i in RECTANGLE_SIGNATURE:
        compiled_params += re.search(i+'="(\S*)"', string).group(1) + ', '
    compiled_params = compiled_params[:-2] # Обрезаем запятую
    compiled_lua = '{0} = controls.{1}:new({2})'.format(compiled_name, compiled_class, compiled_params)
    print(compiled_lua)
    code = code.replace(string, '')

f.close()
