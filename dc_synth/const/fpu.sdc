###################################################################

# Created by write_sdc on Wed May  1 15:38:53 2019

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
create_clock [get_ports gclk]  -name ideal_clock  -period 4  -waveform {0 2}
