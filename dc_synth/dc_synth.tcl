## Give the path to the verilog files and define the WORK directory
#
set username dm3233
lappend search_path /home/${username}@drexel.edu/ecec574/tutorial/OpenSPARC/trunk/T1-FPU/  

define_design_lib WORK -path "work"
#
### Define the library location
set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95vn40c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95vn40c.db ]

set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db]
#
### Read in verilog files
#analyze -library WORK -format verilog [ list bw_clk_cl_fpu_cmp.v fpu_add_ctl.v fpu_add_exp_dp.v fpu_add_frac_dp.v fpu_add.v fpu_cnt_lead0_53b.v fpu_cnt_lead0_64b.v fpu_cnt_lead0_lvl1.v fpu_cnt_lead0_lvl2.v fpu_cnt_lead0_lvl3.v fpu_cnt_lead0_lvl4.v fpu_denorm_3b.v fpu_denorm_3to1.v fpu_denorm_frac.v fpu_div_ctl.v fpu_div_exp_dp.v fpu_div_frac_dp.v fpu_div.v fpu_in2_gt_in1_2b.v fpu_in2_gt_in1_3b.v fpu_in2_gt_in1_3to1.v fpu_in2_gt_in1_frac.v fpu_in_ctl.v fpu_in_dp.v fpu_in.v fpu_mul_ctl.v fpu_mul_exp_dp.v fpu_mul_frac_dp.v fpu_mul.v fpu_out_ctl.v fpu_out_dp.v fpu_out.v fpu_rptr_groups.v fpu_rptr_macros.v fpu_rptr_min_global.v fpu.v cluster_header_ctu.v cluster_header_dup.v cluster_header_sync.v cluster_header.v cmp_sram_redhdr.v dbl_buf.v swrvr_clib.v swrvr_dlib.v synchronizer_asr_dup.v synchronizer_asr.v sync_pulse_synchronizer.v test_stub_bist.v test_stub_scan.v ucb_bus_in.v ucb_bus_out.v ucb_flow_2buf.v ucb_flow_jbi.v ucb_flow_spi.v ucb_noflow.v m1.V bw_r_cm16x40b.v bw_r_cm16x40.v bw_r_dcd.v bw_r_dcm.v bw_r_efa.v bw_rf_16x65.v bw_rf_16x81.v bw_r_frf.v bw_r_icd.v bw_r_idct.v bw_r_irf_fpga1.v bw_r_irf_register.v bw_r_irf.v bw_r_l2d_32k.v bw_r_l2d_rep_bot.v bw_r_l2d_rep_top.v bw_r_l2d.v bw_r_l2t.v bw_r_rf16x128d.v bw_r_rf16x160.v bw_r_rf16x32.v bw_r_rf32x108.v bw_r_rf32x152b.v bw_r_rf32x80.v bw_r_scm.v bw_r_tlb_fpga.v bw_r_tlb.v regfile_1w_4r.v u1.V mul64.v bw_u1_syncff_4x.v bw_u1_soffasr_2x.v bw_u1_scanl_2x.v bw_r_rf16x160.v]

analyze -library WORK -format verilog [list fpu.v bw_r_rf16x160.v bw_clk_cl_fpu_cmp.v  fpu_add_ctl.v fpu_add_exp_dp.v fpu_add_frac_dp.v fpu_add.v fpu_cnt_lead0_53b.v fpu_cnt_lead0_64b.v fpu_cnt_lead0_lvl1.v fpu_cnt_lead0_lvl2.v fpu_cnt_lead0_lvl3.v fpu_cnt_lead0_lvl4.v fpu_denorm_3b.v fpu_denorm_3to1.v fpu_denorm_frac.v fpu_div_ctl.v fpu_div_exp_dp.v fpu_div_frac_dp.v fpu_div.v fpu_in2_gt_in1_2b.v fpu_in2_gt_in1_3b.v fpu_in2_gt_in1_3to1.v fpu_in2_gt_in1_frac.v fpu_in_ctl.v fpu_in_dp.v fpu_in.v fpu_mul_ctl.v fpu_mul_exp_dp.v fpu_mul_frac_dp.v fpu_mul.v fpu_out_ctl.v fpu_out_dp.v fpu_out.v fpu_rptr_groups.v fpu_rptr_macros.v fpu_rptr_min_global.v mul64.v test_stub_scan.v cluster_header.v swrvr_clib.v swrvr_dlib.v u1.V synchronizer_asr.v]

elaborate fpu -architecture verilog -library WORK

current_design fpu

link

### Check if design is consistent
check_design  > reports/synth_check_design.rpt
#
### Create Constraints
set default_clk gclk
set default_clk_freq 1200
set default_setup_skew 0.1
set default_hold_skew 0.1
set default_clk_transition 0.04
set clk_list {{gclk 1200 0.1 0.1 0.04}}
#
### Compilation
### you can change medium to either low or high
compile -area_effort medium -map_effort medium -power_effort medium
#
#
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
