## Give the path to the verilog files and define the WORK directory
#
set username naj47
lappend search_path /home/${username}@drexel.edu/ASICII-Course/tutorial/OpenSPARC/trunk/T1-FPU/

define_design_lib WORK -path "work"
#
### Define the library location
set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95vn40c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v125c.db]
#/mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95vn40c.db ]

set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db]

### Read in verilog files
analyze -library WORK -format verilog [list fpu.v bw_r_rf16x160.v bw_clk_cl_fpu_cmp.v  fpu_add_ctl.v fpu_add_exp_dp.v fpu_add_frac_dp.v fpu_add.v fpu_cnt_lead0_53b.v fpu_cnt_lead0_64b.v fpu_cnt_lead0_lvl1.v fpu_cnt_lead0_lvl2.v fpu_cnt_lead0_lvl3.v fpu_cnt_lead0_lvl4.v fpu_denorm_3b.v fpu_denorm_3to1.v fpu_denorm_frac.v fpu_div_ctl.v fpu_div_exp_dp.v fpu_div_frac_dp.v fpu_div.v fpu_in2_gt_in1_2b.v fpu_in2_gt_in1_3b.v fpu_in2_gt_in1_3to1.v fpu_in2_gt_in1_frac.v fpu_in_ctl.v fpu_in_dp.v fpu_in.v fpu_mul_ctl.v fpu_mul_exp_dp.v fpu_mul_frac_dp.v fpu_mul.v fpu_out_ctl.v fpu_out_dp.v fpu_out.v fpu_rptr_groups.v fpu_rptr_macros.v fpu_rptr_min_global.v mul64.v test_stub_scan.v cluster_header.v swrvr_clib.v swrvr_dlib.v u1.V synchronizer_asr.v]

elaborate fpu -architecture verilog -library WORK

current_design fpu

link

### Check if design is consistent
check_design  > reports/synth_check_design.rpt

set default_clk gclk
reset_design

#Create clock 
create_clock -name ideal_clock -period 90 [get_ports gclk]

#Set Clock Constraints
set_clock_uncertainty 0.1 [get_clocks ideal_clock]
set_clock_latency -max 0.1 [get_clocks ideal_clock]
set_clock_transition 0.1 [get_clocks ideal_clock]

set_input_delay 2.0 [remove_from_collection [all_inputs] gclk] -clock ideal_clock
set_output_delay 2.0 [all_outputs] -clock ideal_clock

set_load 0.3 [all_outputs]

### Compilation
### you can change medium to either low or high
# compile -area_effort medium -map_effort medium -power_effort medium
compile_ultra -gate_clock -retime


### Below commands report area , cell, qor, resources, and timing information needed to analyze the design.
report_power > reports/synth_power.rpt
report_area > reports/synth_area.rpt
report_cell > reports/synth_cells.rpt
report_qor  > reports/synth_qor.rpt
report_resources > reports/synth_resources.rpt
report_timing -max_paths 100 > reports/synth_timing.rpt
# Dump out the constraints in an SDC file
write_sdc  const/fpu.sdc
      
## Dump out the synthesized database and gate-level-netlist
write -f ddc -hierarchy -output output/fpu.ddc
write -hierarchy -format verilog -output  output/fpu.v
exit
