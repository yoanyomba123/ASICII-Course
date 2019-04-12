###### Pre-Layout PrimeTime Script #######
set design s35932

## Define the library location
set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95vn40c.db]

set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db ]
## read the verilog files
read_verilog ../icc_pnr/output/${design}_extract.v

## Set top module name
current_design ${design}

## Read in the extracted parasitics
## Read in SDC from the synthesis 
## read in spef.max for setup time
## read in spef.min for hold time
read_parasitics -format SPEF ../icc_pnr/output/${design}_extract.spef.max

## Read in SDC from the extracted view
source ../icc_pnr/output/${design}_extract.sdc

## Analysis reports

report_timing -from [all_inputs] -max_paths 100 -slack_lesser_than 100 -to [all_registers -data_pins] > reports/${design}_timing.rpt
report_timing -from [all_register -clock_pins] -max_paths 100 -slack_lesser_than 100 -to [all_registers -data_pins]  >> reports/${design}_timing.rpt
report_timing -from [all_registers -clock_pins] -max_paths 100 -slack_lesser_than 100 -to [all_outputs] >> reports/${design}_timing.rpt
report_timing -from [all_inputs] -to [all_outputs] -max_paths 100 -slack_lesser_than 100 >> reports/${design}_timing.rpt
report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type max  >> reports/${design}_timing.rpt
##report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type min  >> reports/timing.rpt

report_timing -transition_time -capacitance -nets -input_pins -from [all_registers -clock_pins] -to [all_registers -data_pins]  > reports/${design}_timing.tran.cap.rpt

report_power > reports/${design}_power.rpt
#report_resources > reports/${design}_resources.rpt
#report_clock_tree
## Save outputs
save_session output/${design}.session


