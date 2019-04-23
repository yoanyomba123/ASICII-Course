set design fpu

#set file_lib "/mnt/class_data/ecec574-f2016/SAED_EDK90nm/Digital_Standard_cell_Library"
set os_path "../OpenSPARC_src/"
#set search_path "$search_path $file_lib/synopsys/models $os_path/include $os_path/common $os_path/lib ./src ./scripts"
#set synthetic_library "dw_foundation.sldb"

# set target_library "saed90nm_typ.db"
# set link_library "* $target_library $synthetic_library"
lappend search_path ${os_path}

define_design_lib WORK -path "work"

set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95vn40c.db]

set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db ]

analyze -f verilog -library WORK [list $os_path/T1-common/common/cluster_header.v \
$os_path/common/swrvr_clib.v \
$os_path/common/swrvr_dlib.v \
$os_path/common/synchronizer_asr.v \
$os_path/T1-FPU/bw_clk_cl_fpu_cmp.v \
$os_path/T1-FPU/fpu_add_ctl.v \
$os_path/T1-FPU/fpu_add_exp_dp.v \
$os_path/T1-FPU/fpu_add_frac_dp.v \
$os_path/T1-FPU/fpu_add.v \
$os_path/T1-FPU/fpu_cnt_lead0_53b.v \
$os_path/T1-FPU/fpu_cnt_lead0_64b.v \
$os_path/T1-FPU/fpu_cnt_lead0_lvl1.v \
$os_path/T1-FPU/fpu_cnt_lead0_lvl2.v \
$os_path/T1-FPU/fpu_cnt_lead0_lvl3.v \
$os_path/T1-FPU/fpu_cnt_lead0_lvl4.v \
$os_path/T1-FPU/fpu_denorm_3b.v \
$os_path/T1-FPU/fpu_denorm_3to1.v \
$os_path/T1-FPU/fpu_denorm_frac.v \
$os_path/T1-FPU/fpu_div_ctl.v \
$os_path/T1-FPU/fpu_div_exp_dp.v \
$os_path/T1-FPU/fpu_div_frac_dp.v \
$os_path/T1-FPU/fpu_div.v \
$os_path/T1-FPU/fpu_in2_gt_in1_2b.v \
$os_path/T1-FPU/fpu_in2_gt_in1_3b.v \
$os_path/T1-FPU/fpu_in2_gt_in1_3to1.v \
$os_path/T1-FPU/fpu_in2_gt_in1_frac.v \
$os_path/T1-FPU/fpu_in_ctl.v \
$os_path/T1-FPU/fpu_in_dp.v \
$os_path/T1-FPU/fpu_in.v \
$os_path/T1-FPU/fpu_mul_ctl.v \
$os_path/T1-FPU/fpu_mul_exp_dp.v \
$os_path/T1-FPU/fpu_mul_frac_dp.v \
$os_path/T1-FPU/fpu_mul.v \
$os_path/T1-FPU/fpu_out_ctl.v \
$os_path/T1-FPU/fpu_out_dp.v \
$os_path/T1-FPU/fpu_out.v \
$os_path/T1-FPU/fpu_rptr_groups.v \
$os_path/T1-FPU/fpu_rptr_macros.v \
$os_path/T1-FPU/fpu_rptr_min_global.v \
$os_path/T1-CPU/mul/mul64.v \
$os_path/T1-common/common/test_stub_scan.v \
$os_path/T1-common/srams/bw_r_rf16x160.v \
$os_path/T1-FPU/fpu.v]
#
# # Now moving onto s15850 sample benchmark. 
#rci
elaborate -architecture verilog -library WORK fpu
current_design fpu
link
#
# # Set the clock consraints
#
create_clock gclk -period 6
set_clock_transition 0.04 gclk
set_clock_uncertainty 0.1 gclk
set_clock_latency -max 0.4 gclk
#
# # Comile for optimization reports
#
compile_ultra -no_autoungroup -timing_high_effort_script
#ccompile_ultra -gate_clock -timing_high_effort_script
# compile
write_sdc ./const/fpu.sdc
#
# #Reports for different constraints 
# #report_wire_load > logs/s15850/wire.report
report_cell > logs/cell.report
report_timing > logs/timing.report
report_power  > logs/power.report 
# #report_clock  > logs/s15850/clk_def.report
# #report_clock_timing -type transition -clock CK  > logs/s15850/transition_clock.report
# #report_clock_timing -type skew -clock CK  > logs/s15850/skew_clock.report
# #report_clock_timing -type latency -clock CK  > logs/s15850/latency_clock.report
#
# #write output
write -hierarchy -f ddc -output output/fpu.ddc
write -hierarchy -f verilog -output output/fpu.v

exit
