#when "1100011" => lut_sig <= to_unsigned(integer(my_rom(99)),16);
var = 4096

with open('wehn_readme.txt', 'w') as f:
    for i in range(4096):
        #if i % 20:
        f.write('when "')
        f.write(hex(i))
        f.write('" => lut_sig <= to_unsigned(integer(my_rom(' + str(i))
        f.write(')),16);')
        f.write('\n')