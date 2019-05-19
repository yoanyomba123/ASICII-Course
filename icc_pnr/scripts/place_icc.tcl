###########################################################################
### Placement
###########################################################################
set design fpu_place

set_buffer_opt_strategy -effort low

set_tlu_plus_files -max_tluplus /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus -min_tluplus /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus -tech2itf_map /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map

##Goto Layout Window , Placement ' Core Placement and Optimization .  A new window opens up as shown below . There are various options, you can click on what ever option you want and say ok. The tool will do the placement. Alternatively you can also run at the command at icc_shell . Below is example with congestion option.
get_scan_chains

# Performs coarse placement on the current design
create_placement -effort high -timing_driven -congestion -congestion_effort high

# executes detailed placement on a design
legalize_placement -effort high 

# places all cells and spreads cells apart that may be in areas of high routing to provide stacks and increase the odds of a successful route later
place_opt -effort high -congestion -area_recovery -power -cts

# uses derive_pg_connection in manual mode to connect all unconnected power pins to VDDA adn all unconnected ground pins to VSS 
# -tie connects the tie high and tie low pins to power nets and ground nets
derive_pg_connection -create_nets -all -resolve_conflict -reconnect -preserve_physical_only_pg 

# conenct the rows to the rings/straps
preroute_standard_cells -nets {VDDA VSS} -connect horizontal -extend_to_boundaries_and_generate_pins -optimize_via_locations 

# checks a design's prerequisite for detail routing and must be done before routing. Will normally output a list of violations if any
# check_routeability
save_mw_cel -as ${design}

### Reports 

report_placement_utilization > output/${design}_util.rpt
report_place_opt_strategy > output/${design}_place_opt.rpt
report_qor_snapshot > output/${design}_qor_snapshot.rpt
report_qor > output/${design}_qor.rpt

### Timing Report

report_timing -delay max -max_paths 20 > output/${design}.setup.rpt
report_timing -delay min -max_paths 20 > output/${design}.hold.rpt

### Perform clock optimization
# useful to prevent the upsizing of exisitng clock gates before clustering
cts_prects_upsize_gates 'false'
# prevent moving of existing clock gates prior to clustering
cts_move_clock_gate 'true'

# clock tree with root idela_clock impelemented with a set of specified library references to be used as buffers. Clock ideal_clock is compiled and updated in the design netlist
set_clock_tree_options -clock_trees [get_clocks ideal_clock]
compile_clock_tree -clock_trees ideal_clock

# perform clock tree synthesis as well as other things such as optimization and hold time violation fixing.  Additionally no-route stops actual routing from being performed so that we can see what the clock tree will look like before the routing steps
clock_opt -only_cts -no_clock_route

# perform clock tree synthesis for the given clock and fix all hold time violations
clock_opt -clock_tree ideal_clock -fix_hold_all_clocks -no_clock_route -power

# adjust input and output delay based on the actual clock arrvial times
update_clock_latency

# Perfrom inter clock balancing by performing delay insertation at the clock root. It the clock root net hs a dont buffer exception, icc cannot perform interclock delay 
# balancing. If the clock root is defined as a port of a pad cell the delay insertion is performed on the net driven by the pad cell
balance_inter_clock_delay

# perform clock optimization feasibility analysis after clock_opt
clock_opt_feasibility -only_psyn

# perform detail routing of the clock nets
route_zrt_group -all_clock_nets -reuse_existing_global_route true

# report the actual clock tree synthesis
report_clock_tree -clock_tree [get_clocks ideal_clock] > output/${design}.cts.rpt
exit
