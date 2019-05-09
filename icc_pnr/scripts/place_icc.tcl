###########################################################################
### Placement
###########################################################################
set design fpu_place
`
set_buffer_opt_strategy -effort low

set_tlu_plus_files -max_tluplus /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus -min_tluplus /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus -tech2itf_map /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map

##Goto Layout Window , Placement ' Core Placement and Optimization .  A new window opens up as shown below . There are various options, you can click on what ever option you want and say ok. The tool will do the placement. Alternatively you can also run at the command at icc_shell . Below is example with congestion option.


place_opt -congestion

# checks a design's prerequisite for detail routing and must be done before routing. Will normally output a list of violations if any
# check_routeability
save_mw_cel -as ${design}

### Reports 

report_placement_utilization > output/${design}_util.rpt
report_qor_snapshot > output/${design}_qor_snapshot.rpt
report_qor > output/${design}_qor.rpt

### Timing Report

report_timing -delay max -max_paths 20 > output/${design}.setup.rpt
report_timing -delay min -max_paths 20 > output/${design}.hold.rpt


