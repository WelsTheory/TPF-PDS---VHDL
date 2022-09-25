library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sin_entity is
    Port (
        address: in std_logic_vector(6 downto 0);
        sine: out std_logic_vector(15 downto 0)
    );
end entity;

architecture Behavioral of sin_entity is
    
    type mem is array(0 to 99) of real;
    constant my_rom: mem := (
        0=>750.0,
1=>797.5679397424234,
2=>844.944340180312,
3=>891.9384332703077,
4=>938.3609903858094,
5=>984.0250842738653,
6=>1028.7468417452455,
7=>1072.3461840668788,
8=>1114.6475520753515,
9=>1155.4806130916982,
10=>1194.6809467909804,
11=>1232.0907072649045,
12=>1267.559258611584,
13=>1300.94378149315,
14=>1332.1098482188177,
15=>1360.9319640377516,
16=>1387.2940724621358,
17=>1411.0900225856867,
18=>1432.2239965158888,
19=>1450.61089519883,
20=>1466.1766810830554,
21=>1478.8586762426562,
22=>1488.6058147591561,
23=>1495.3788483459407,
24=>1499.150504387256,
25=>1499.9055957554065,
26=>1497.6410819639568,
27=>1492.3660814106995,
28=>1484.101834661084,
29=>1472.8816189199565,
30=>1458.7506140360015,
31=>1441.765720578436,
32=>1421.995330718502,
33=>1399.519052838329,
34=>1374.4273909760784,
35=>1346.821380398124,
36=>1316.8121807656937,
37=>1284.520628534147,
38=>1250.076750387219,
39=>1213.6192396654537,
40=>1175.2948978970778,
41=>1135.2580436800547,
42=>1093.6698912955578,
43=>1050.6979015549603,
44=>1006.5151074942514,
45=>961.2994176310723,
46=>915.2328995899053,
47=>868.5010469800121,
48=>821.2920324781371,
49=>773.7959501235507,
50=>726.2040498764491,
51=>678.7079675218627,
52=>631.4989530199874,
53=>584.7671004100946,
54=>538.7005823689276,
55=>493.4848925057485,
56=>449.30209844503935,
57=>406.330108704442,
58=>364.7419563199454,
59=>324.7051021029218,
60=>286.38076033454604,
61=>249.9232496127811,
62=>215.47937146585275,
63=>183.18781923430595,
64=>153.17861960187588,
65=>125.57260902392159,
66=>100.48094716167088,
67=>78.00466928149797,
68=>58.23427942156377,
69=>41.24938596399875,
70=>27.118381080043378,
71=>15.898165338915987,
72=>7.633918589300492,
73=>2.3589180360431783,
74=>0.09440424459364749,
75=>0.8494956127440219,
76=>4.6211516540594175,
77=>11.394185240843854,
78=>21.141323757343798,
79=>33.82331891694457,
80=>49.38910480117022,
81=>67.77600348411136,
82=>88.90997741431352,
83=>112.70592753786423,
84=>139.06803596224813,
85=>167.89015178118257,
86=>199.0562185068501,
87=>232.44074138841643,
88=>267.9092927350958,
89=>305.31905320901984,
90=>344.5193869083019,
91=>385.3524479246484,
92=>427.6538159331216,
93=>471.25315825475457,
94=>515.9749157261354,
95=>561.6390096141904,
96=>608.061566729692,
97=>655.0556598196882,
98=>702.4320602575766,
99=>749.9999999999998
    );

signal lut_sig : unsigned(15 downto 0);

begin 
    sine <= STD_LOGIC_VECTOR(lut_sig);
    process (address)
            begin
                case address is
                    when "0000000" => lut_sig <= to_unsigned(integer(my_rom(0)),16);
                    when "0000001" => lut_sig <= to_unsigned(integer(my_rom(1)),16);
                    when "0000010" => lut_sig <= to_unsigned(integer(my_rom(2)),16);
                    when "0000011" => lut_sig <= to_unsigned(integer(my_rom(3)),16);
                    when "0000100" => lut_sig <= to_unsigned(integer(my_rom(4)),16);
                    when "0000101" => lut_sig <= to_unsigned(integer(my_rom(5)),16);
                    when "0000110" => lut_sig <= to_unsigned(integer(my_rom(6)),16);
                    when "0000111" => lut_sig <= to_unsigned(integer(my_rom(7)),16);
                    when "0001000" => lut_sig <= to_unsigned(integer(my_rom(8)),16);
                    when "0001001" => lut_sig <= to_unsigned(integer(my_rom(9)),16);
                    when "0001010" => lut_sig <= to_unsigned(integer(my_rom(10)),16);
                    when "0001011" => lut_sig <= to_unsigned(integer(my_rom(11)),16);
                    when "0001100" => lut_sig <= to_unsigned(integer(my_rom(12)),16);
                    when "0001101" => lut_sig <= to_unsigned(integer(my_rom(13)),16);
                    when "0001110" => lut_sig <= to_unsigned(integer(my_rom(14)),16);
                    when "0001111" => lut_sig <= to_unsigned(integer(my_rom(15)),16);
                    when "0010000" => lut_sig <= to_unsigned(integer(my_rom(16)),16);
                    when "0010001" => lut_sig <= to_unsigned(integer(my_rom(17)),16);
                    when "0010010" => lut_sig <= to_unsigned(integer(my_rom(18)),16);
                    when "0010011" => lut_sig <= to_unsigned(integer(my_rom(19)),16);
                    when "0010100" => lut_sig <= to_unsigned(integer(my_rom(20)),16);
                    when "0010101" => lut_sig <= to_unsigned(integer(my_rom(21)),16);
                    when "0010110" => lut_sig <= to_unsigned(integer(my_rom(22)),16);
                    when "0010111" => lut_sig <= to_unsigned(integer(my_rom(23)),16);
                    when "0011000" => lut_sig <= to_unsigned(integer(my_rom(24)),16);
                    when "0011001" => lut_sig <= to_unsigned(integer(my_rom(25)),16);
                    when "0011010" => lut_sig <= to_unsigned(integer(my_rom(26)),16);
                    when "0011011" => lut_sig <= to_unsigned(integer(my_rom(27)),16);
                    when "0011100" => lut_sig <= to_unsigned(integer(my_rom(28)),16);
                    when "0011101" => lut_sig <= to_unsigned(integer(my_rom(29)),16);
                    when "0011110" => lut_sig <= to_unsigned(integer(my_rom(30)),16);
                    when "0011111" => lut_sig <= to_unsigned(integer(my_rom(31)),16);
                    when "0100000" => lut_sig <= to_unsigned(integer(my_rom(32)),16);
                    when "0100001" => lut_sig <= to_unsigned(integer(my_rom(33)),16);
                    when "0100010" => lut_sig <= to_unsigned(integer(my_rom(34)),16);
                    when "0100011" => lut_sig <= to_unsigned(integer(my_rom(35)),16);
                    when "0100100" => lut_sig <= to_unsigned(integer(my_rom(36)),16);
                    when "0100101" => lut_sig <= to_unsigned(integer(my_rom(37)),16);
                    when "0100110" => lut_sig <= to_unsigned(integer(my_rom(38)),16);
                    when "0100111" => lut_sig <= to_unsigned(integer(my_rom(39)),16);
                    when "0101000" => lut_sig <= to_unsigned(integer(my_rom(40)),16);
                    when "0101001" => lut_sig <= to_unsigned(integer(my_rom(41)),16);
                    when "0101010" => lut_sig <= to_unsigned(integer(my_rom(42)),16);
                    when "0101011" => lut_sig <= to_unsigned(integer(my_rom(43)),16);
                    when "0101100" => lut_sig <= to_unsigned(integer(my_rom(44)),16);
                    when "0101101" => lut_sig <= to_unsigned(integer(my_rom(45)),16);
                    when "0101110" => lut_sig <= to_unsigned(integer(my_rom(46)),16);
                    when "0101111" => lut_sig <= to_unsigned(integer(my_rom(47)),16);
                    when "0110000" => lut_sig <= to_unsigned(integer(my_rom(48)),16);
                    when "0110001" => lut_sig <= to_unsigned(integer(my_rom(49)),16);
                    when "0110010" => lut_sig <= to_unsigned(integer(my_rom(50)),16);
                    when "0110011" => lut_sig <= to_unsigned(integer(my_rom(51)),16);
                    when "0110100" => lut_sig <= to_unsigned(integer(my_rom(52)),16);
                    when "0110101" => lut_sig <= to_unsigned(integer(my_rom(53)),16);
                    when "0110110" => lut_sig <= to_unsigned(integer(my_rom(54)),16);
                    when "0110111" => lut_sig <= to_unsigned(integer(my_rom(55)),16);
                    when "0111000" => lut_sig <= to_unsigned(integer(my_rom(56)),16);
                    when "0111001" => lut_sig <= to_unsigned(integer(my_rom(57)),16);
                    when "0111010" => lut_sig <= to_unsigned(integer(my_rom(58)),16);
                    when "0111011" => lut_sig <= to_unsigned(integer(my_rom(59)),16);
                    when "0111100" => lut_sig <= to_unsigned(integer(my_rom(60)),16);
                    when "0111101" => lut_sig <= to_unsigned(integer(my_rom(61)),16);
                    when "0111110" => lut_sig <= to_unsigned(integer(my_rom(62)),16);
                    when "0111111" => lut_sig <= to_unsigned(integer(my_rom(63)),16);
                    when "1000000" => lut_sig <= to_unsigned(integer(my_rom(64)),16);
                    when "1000001" => lut_sig <= to_unsigned(integer(my_rom(65)),16);
                    when "1000010" => lut_sig <= to_unsigned(integer(my_rom(66)),16);
                    when "1000011" => lut_sig <= to_unsigned(integer(my_rom(67)),16);
                    when "1000100" => lut_sig <= to_unsigned(integer(my_rom(68)),16);
                    when "1000101" => lut_sig <= to_unsigned(integer(my_rom(69)),16);
                    when "1000110" => lut_sig <= to_unsigned(integer(my_rom(70)),16);
                    when "1000111" => lut_sig <= to_unsigned(integer(my_rom(71)),16);
                    when "1001000" => lut_sig <= to_unsigned(integer(my_rom(72)),16);
                    when "1001001" => lut_sig <= to_unsigned(integer(my_rom(73)),16);
                    when "1001010" => lut_sig <= to_unsigned(integer(my_rom(74)),16);
                    when "1001011" => lut_sig <= to_unsigned(integer(my_rom(75)),16);
                    when "1001100" => lut_sig <= to_unsigned(integer(my_rom(76)),16);
                    when "1001101" => lut_sig <= to_unsigned(integer(my_rom(77)),16);
                    when "1001110" => lut_sig <= to_unsigned(integer(my_rom(78)),16);
                    when "1001111" => lut_sig <= to_unsigned(integer(my_rom(79)),16);
                    when "1010000" => lut_sig <= to_unsigned(integer(my_rom(80)),16);
                    when "1010001" => lut_sig <= to_unsigned(integer(my_rom(81)),16);
                    when "1010010" => lut_sig <= to_unsigned(integer(my_rom(82)),16);
                    when "1010011" => lut_sig <= to_unsigned(integer(my_rom(83)),16);
                    when "1010100" => lut_sig <= to_unsigned(integer(my_rom(84)),16);
                    when "1010101" => lut_sig <= to_unsigned(integer(my_rom(85)),16);
                    when "1010110" => lut_sig <= to_unsigned(integer(my_rom(86)),16);
                    when "1010111" => lut_sig <= to_unsigned(integer(my_rom(87)),16);
                    when "1011000" => lut_sig <= to_unsigned(integer(my_rom(88)),16);
                    when "1011001" => lut_sig <= to_unsigned(integer(my_rom(89)),16);
                    when "1011010" => lut_sig <= to_unsigned(integer(my_rom(90)),16);
                    when "1011011" => lut_sig <= to_unsigned(integer(my_rom(91)),16);
                    when "1011100" => lut_sig <= to_unsigned(integer(my_rom(92)),16);
                    when "1011101" => lut_sig <= to_unsigned(integer(my_rom(93)),16);
                    when "1011110" => lut_sig <= to_unsigned(integer(my_rom(94)),16);
                    when "1011111" => lut_sig <= to_unsigned(integer(my_rom(95)),16);
                    when "1100000" => lut_sig <= to_unsigned(integer(my_rom(96)),16);
                    when "1100001" => lut_sig <= to_unsigned(integer(my_rom(97)),16);
                    when "1100010" => lut_sig <= to_unsigned(integer(my_rom(98)),16);
                    when "1100011" => lut_sig <= to_unsigned(integer(my_rom(99)),16);
                    when others => lut_sig <= "0000000000000000";
                end case;
            end process;
end Behavioral;
