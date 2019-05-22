###### Pre-Layout PrimeTime Script #######

### Define the library location
set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db] 

#
set target_library [list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db]
#

# This links the rvt libraries of the fpu design. We need this to run or we get unresolved references. Changing to lvt gives "unresolved references".
set link_path "* /mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db"
# Getting errors on nets is okay because this is not the complete openSPARC file.

## read the verilog files
read_verilog ../icc_pnr/output/fpu_extracted.v
#
#
#
set power_enable_analysis "true"
### Set top module name
current_design fpu
#
set link_create_black_boxes false
###link_design
### Read in the extracted parasitics
### Read in SDC from the synthesis 
### read in spef.max for setup time
### read in spef.min for hold time
read_parasitics -format SPEF ../icc_pnr/output/fpu_extracted.spef.max
#
### Read in SDC from the extracted view
read_sdc ../icc_pnr/output/fpu_extracted.sdc
#
### Analysis reports
#
report_timing -from [all_inputs] -max_paths 100 -to [all_registers -data_pins] -slack_lesser_than 100  > reports/fpu_timing.rpt
report_timing -from [all_register -clock_pins] -max_paths 100 -to [all_registers -data_pins]  -slack_lesser_than 100 >> reports/fpu_timing.rpt
report_timing -from [all_registers -clock_pins] -max_paths 100 -to [all_outputs] -slack_lesser_than 100 >> reports/fpu_timing.rpt
report_timing -from [all_inputs] -to [all_outputs] -max_paths 100 -slack_lesser_than 100 >> reports/fpu_timing.rpt
report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type max -slack_lesser_than 100  >> reports/fpu_timing.rpt
report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type min  -slack_lesser_than 100 >> reports/fpu_timing.rpt
#
report_timing -transition_time -capacitance -nets -input_pins -from [all_registers -clock_pins] -to [all_registers -data_pins]  > reports/fpu.tran.cap.rpt
#
report_power -verbose -hierarchy > reports/fpu_power.rpt
#
### Save outputs
save_session output/fpu.session
#
#
