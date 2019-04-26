###################################################################

# Created by write_sdc on Thu Apr 25 23:52:21 2019

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
create_clock [get_ports gclk]  -name ideal_clock  -period 2  -waveform {0 1}
