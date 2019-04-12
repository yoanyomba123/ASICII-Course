
###### DC Synthesis Script #######

## Give the path to the verilog files and define the WORK directory

lappend search_path ../T1-FPU/
define_design_lib WORK -path "work"

## Define the library location
set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95vn40c.db]

set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db ]

# This is nick

## read the verilog files
analyze -library WORK -format verilog [list fpu.v bw_clk_cl_fpu_cmp.v
fpu_add_ctl.v
fpu_add_exp_dp.v
fpu_add_frac_dp.v
fpu_add.v
fpu_cnt_lead0_53b.v
fpu_cnt_lead0_64b.v
fpu_cnt_lead0_lvl1.v
fpu_cnt_lead0_lvl2.v
fpu_cnt_lead0_lvl3.v
fpu_cnt_lead0_lvl4.v
fpu_denorm_3b.v
fpu_denorm_3to1.v
fpu_denorm_frac.v
fpu_div_ctl.v
fpu_div_exp_dp.v
fpu_div_frac_dp.v
fpu_div.v
fpu_in2_gt_in1_2b.v
fpu_in2_gt_in1_3b.v
fpu_in2_gt_in1_3to1.v
fpu_in2_gt_in1_frac.v
fpu_in_ctl.v
fpu_in_dp.v
fpu_in.v
fpu_mul_ctl.v
fpu_mul_exp_dp.v
fpu_mul_frac_dp.v
fpu_mul.v
fpu_out_ctl.v
fpu_out_dp.v
fpu_out.v
fpu_rptr_groups.v
fpu_rptr_macros.v
fpu_rptr_min_global.v
]

elaborate   -architecture verilog -library WORK fpu

## Check if design is consistent
check_design  > reports/synth_check_design_project.rpt

## Create Constraints 
create_clock CK -name ideal_clock1 -period 2
set_input_delay 2.0 [ remove_from_collection [all_inputs] CK ] -clock ideal_clock1
set_output_delay 2.0 [all_outputs ] -clock ideal_clock1
set_max_area 0 
set_load 0.3 [ all_outputs ]
set_clock_latency 0.4 [get_clocks ideal_clock1]
set_clock_uncertainty 0.05 [get_clocks ideal_clock1]
set_clock_transition 0.1 [get_clocks ideal_clock1]


## Compilation 
## you can change medium to either low or high 
compile -area_effort medium -map_effort medium


## Below commands report area , cell, qor, resources, and timing information needed to analyze the design. 

  report_area > reports/synth_area_project.rpt
  report_cell > reports/synth_cells_project.rpt
  report_qor  > reports/synth_qor_project.rpt
  report_resources > reports/synth_resources_project.rpt
  report_timing -max_paths 10 > reports/synth_timing_project.rpt
  report_power > reports/synth_power_project.rpt
## Dump out the constraints in an SDC file

  write_sdc  const/project.sdc

## Dump out the synthesized database and gate-level-netlist
  write -f ddc -hierarchy -output output/project.ddc

  write -hierarchy -format verilog -output  output/project.v

  exit
