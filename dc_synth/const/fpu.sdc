###################################################################

# Created by write_sdc on Wed May  8 21:01:55 2019

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
create_clock [get_ports gclk]  -name ideal_clock  -period 123  -waveform {0 61.5}
