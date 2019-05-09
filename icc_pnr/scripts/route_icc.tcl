# define the given design rout
set route_name fpu_route

###########################################################################
### Routing
# After CTS, the routing process determines the precise paths for interconnections. This includes the standard cell and macro pins, the pins on the block boundary or pads at the chip boundary. After placement and CTS,the tool has information about the exact locations of blocks, pins of blocks, and I/O pads at chip boundaries. The logical connectivity as defined by the netlist is also available to the tool. In routing stage, metal and vias are used to create the electrical connection in layout so as to complete all connections defined by the netlist. Now, to do the actual interconnections, the tool relies on some “Design Rules”. It is essential that
# Tool completes all connections that are defined by the netlist (100% routability), i.e. no LVS errors.
# No design rules are violated in completing the routes(No DRC errors).
# All timing constraints are met.
###########################################################################
#
#
#Global Routing
#The PnR tools you use may let you do routing in various stages, like global routing, track assignment and detailed routing. It could also be that all these algorithmic stages are masked from you and you just have a couple of commands to play with. Most PnR tools deal with the routing problem in a two stage approach. In global routing, the tool partitions the design into routing regions. A rough route is determined taking into account the number of tracks available in each region. Routing congestion is also determined at this stage by calculating 1) how many nets should pass through the region; 2) How many routing tracks are available in the region. In detailed routing, global routing results are used to lay the actual wires interconnecting the nodes.
#
#
#t is difficult to route a highly congested design. Some not-so congested designs may have pockets of high congestion which will again create routing issues. It is important that the congestion is analysed and fixed before detailed routing. After CTS, the tool can give you a congestion map by a trial route/ global route values
#
##In the layout window, click on Route -> Core Routing and Optimization

##==================== Power Routing ==========================##
preroute_standard_cells -connect horizontal -do_not_route_over_macros
verify_pg_nets

##=================== Clock Routing ==========================##
set_route_options \
	-groute_skew_control true \
	-groute_clock_routing balanced \
	-droute_CTS_nets normal \
	-same_net_notch check_and_fix \
	-fat_wire_check merge_then_check \
	-merge_fat_wire_on preroute_signal \
	-fat_blockage_as fat_wire
set_route_zrt_common_options -concurrent_redundant_via_mode insert_at_high_cost
route_zrt_clock_tree

###===================== Signal Routing =====================++++#
set_route_zrt_detail_options -port_antenna_mode jump
check_routeability

route_zrt_group \
	-all_clock_nets
	-reuse_existing_global_route true

route_opt -initial_route_only
route_opt -skip_initial_route -effort high -concurrent_clock_and_data -xtalk_reduction -area_recovery -wire_size -optimize_wire_via -num_cpus 16
# optimizes routing and performs incremental timing fixes
# enables block interface optimization and runs incremental optimization
set_host_options -pool LSF -name "LSF_hosts"
set_top_implementation_options -optimize_block_interface true -host_options "LSF_hosts"
route_opt -incremental


#iiiave the cel and report timing
write_verilog "./output/res.v"

## Generate rc parasitics
extract_rc
write_parasitics -format sbpf -output "./output/res_parasitics.sbpf"

save_mw_cel -as ${route_name}
report_placement_utilization > reports/${route_name}_util.rpt
report_qor_snapshot > reports/${route_name}_qor_snapshot.rpt
report_qor > reports/${route_name}_qor.rpt
report_timing -max_paths 20 -delay max > reports/${route_name}.setup.rpt
report_timing -max_paths 20 -delay min > reports/${route_name}.hold.rpt

#report_timing > reports/${route_name}.timing.rpt
#report_power > reports/${route_name}.power.rpt
#report_drc_error_types > reports/${route_name}.drc.rpt

##POST ROUTE OPTIMIZATION STEPS

##Goto Layout Window, Route -> Verify Route

exit
