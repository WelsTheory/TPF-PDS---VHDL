#when "1100011" => lut_sig <= to_unsigned(integer(my_rom(99)),16);

with open('when_cos_readme.txt', 'w') as f:
    for i in range(4096):
        f.write('when "')
        f.write(hex(i))
        f.write('" => lut_sig <= to_unsigned(integer(my_cos(' + str(i))
        f.write(')),16);')
        f.write('\n')