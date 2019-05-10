set design fpu
set cellname ${design}
set designv ${design}.v
set ddc ${design}.ddc
set sdc ${design}.sdc
set frequency 100
set mw $design.mw 

set search_path "$search_path /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs ../../tutorial/OpenSPARC/trunk/T1-FPU/"
#set target_library "saed32rvt_ss0p95v25c.db"
#set link_library "* $target_library"


set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95vn40c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95vn40c.db ]

set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db]

sh rm -rf ${mw}

start_gui
set techfile "/mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/milkyway/saed32nm_1p9m_mw.tf"
set ref_lib "/mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/milkyway/saed32nm_rvt_1p9m"
set lib_name "fpu"

set design_data ../dc_synth/output/${ddc}
set cell_name "fpu"
import_designs $design_data -format ddc -top $cell_name

set mw_logic0_net VSS
set mw_logic1_net VDD

set libdir "/mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt"
set tlupmax "$libdir/saed32nm_1p9m_Cmax.tluplus"
set tlunom "$libdir/saed32nm_1p9m_nominal.tluplus"
set tlupmin "$libdir/saed32nm_1p9m_Cmin.tluplus"
set tech2itf "$libdir/saed32nm_tf_itf_tluplus.map"
set_tlu_plus_files -max_tluplus $tlunom -tech2itf_map $tech2itf

create_mw_lib $lib_name.mw \
		 -technology $techfile \
		 -mw_reference_library $ref_lib 
		 
open_mw_lib $lib_name.mw

read_verilog ../dc_synth/output/${designv}

uniquify_fp_mw_cel

link

read_sdc ../dc_synth/const/${sdc}

save_mw_cel -as ${design}_initial






set floorplan_design fpu_fp
###########################################################################
### Floorplanning
###########################################################################

# createte_floorplan -core_utilization 0.6 -left_io2core 5 -bottom_io2core 5 -right_io2core 5 -top_io2core 5
#
# ##Create VSS ring
#
# create_rectangular_rings  -nets  {VSS}  -left_offset 0.5  -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 0.5 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 0.5  -bottom_segment_layer  M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 0.5 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th
#
# ## Create VDDa Ring
#
# create_rectangular_rings  -nets  {VDDA}  -left_offset 1.8  -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 1.8 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 1.8  -bottom_segment_layer M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 1.8 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th
#
# ## Creates Power Strap
#
# create_power_strap -nets { VDDA } -layer M6 -direction vertical -width 3
# create_power_strap -nets { VSS } -layer M6 -direction vertical  -width 3
#
# ## Save the design
#
# save_mw_cel -as ${floorplan_design}
#
# ~
# ~

# setup the routing for different metal layers
#  Metal 1
#  (M1) is the lowest layer in this process, which can connect directly to the standard cells which are
#  below all of the metal. The MRDL layer is the highest layer in this process, although that specific
#  metal layer should not be used for much routing. This is due to the fact that it is the top-most
#  layer, and in most processes the parameters of this layer are not optimal for digital routing.
# set_preferred_routing_direction -layers {M1 M3 M5 M7 M9 MRDL} -direction vertical
# set_preferred_routing_direction -layers {M2 M4 M6 M8 MRDL} -direction horizontal

# set physical constraints on pads
# The create floorplan command tells the tool to create the area in which to place all of the
# standard cells, and all of the wires for routing. The -core utilization flag means that you want
# the design to be occupied by 60% actual standard cells, with 40% filler cells. The reason that you
# cannot push this too high is that most designs will not be limited by the area of the standard cells
# themselves, it will be limited by routing which gets exponentially worse the closer packed together
# things are. The -flip first row flag specifies to flip the first row at the bottom of the core area.
# Standard cell rows are abutted together to share either a common VDD or a common GND with the
# row below them. The orientation of the next row is flipped relative to the one below it since you
# want two VDD connections together rather than shorting VDD to GND.
# The multiple io2core flags specify the extra space in micrometers on specific sides of the core
# to the io cells. The -row core ratio flag with the value of 1 tells the core area to only include
# standard cells, and leave no space for routing tracks.
#
# this command allocates space for the chip and palce the pins evenly on the border
create_floorplan -control_type aspect_ratio -core_aspect_ratio "1" -core_utilization 0.6 -start_first_row -left_io2core 15 -bottom_io2core 15 -right_io2core 15 -top_io2core 15 -row_core_ratio 1

derive_pg_connection -power_net VDDA -ground_net VSS
derive_pg_connection -power_net VDDA -ground_net VSS -tie
# create power rings around the edge
create_rectilinear_rings -nets {VDDA VSS} -offset {1 1} -width {3 3} -space {3 3}

##Create VSS ring
create_rectangular_rings  -nets  {VSS}  -left_offset 0.5  -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 0.5 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 0.5  -bottom_segment_layer  M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 0.5 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th
 
## Create VDDa Ring
create_rectangular_rings  -nets  {VDDA}  -left_offset 1.8  -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 1.8 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 1.8  -bottom_segment_layer M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 1.8 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th

## Creates Power Strap 
create_power_strap -nets { VDDA } -layer M6 -direction vertical -width 3  
create_power_strap -nets { VSS } -layer M6 -direction vertical  -width 3
# create_fp_placement -num_cpus 16
# remove standard cells and regenerate them
# cut_row -all
#add_row \
#-within [get_attr [get_core_area] bbox] \
#-direction horizontal \
#-flip_first_row \
#-tile_name unit \
#-bottom_offset 0.2

# set floorplan placement strategy
#set_fp_placement_strategy -macros_on_edge auto
#set_keepout_margin -type soft -north -outer {2 2 2 2} [all_macro_cells]

# create initial placement
#create_fp_placement -timing_driven -no_hierarchy_gravity -num_cpus 16

## Generate the floorplan power rails
#synthesize_fp_rail \
# -power_budget 1000 \
# -voltage_supply 1.2 \
# -target_voltage_drop 250 \
# -nets "VDD VSS" \
# -output_dir "./power.pna" \
# -create_virtual_rails M1 \
# -synthesize_power_plan \
# -synthesize_power_pads \
# -use_strap_ends_as_pads

## Committing the design options chosen in the above commands
#commit_fp_rail
# put in power straps
#set_preroute_drc_strategy \
#-min_layer M2 \
#-max_layer MRDL

# compile the power plan
#compile_power_plan

# After we put in the power straps, we insert filler cells to connect up all of the supply rails. These
# filler cells are the same size as the standard cells, but do not contain actual transistors. They are
# there to ensure that the power connections are made and that density of the layers involved in the
# transistor are maintained.
#insert_stdcell_filler \
#-cell_without_metal "SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT SHFILL1_RVT"#-connect_to_power {VDD} \
#-connect_to_ground {VSS}

#set_preroute_drc_strategy \
-min_layer M2 \
-max_layer M5
# preroute standard cell rails and connect supply rails in metal 1 to the grid
#preroute_standard_cells -connect horizontal \
# -nets {VDD VSS} \
# -port_filter_mode off \
# -route_pins_on_layer M1 \
# -cell_master_filter_mode off \
# -cell_instance_filter_mode off \
# -voltage_area_filter_mode off \
# -remove_floating_pieces 
# verify connectivity of power/ground nets
#verify_pg_nets
# get rid of filler cells
#remove_stdcell_filler -stdcell
# verify connectivity of power/ground nets
#verify_pg_nets


## Save the design

save_mw_cel -as ${floorplan_design}


###########################################################################
### Placement
###########################################################################
set design fpu_place

set_buffer_opt_strategy -effort low

set_tlu_plus_files -max_tluplus /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus -min_tluplus /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus -tech2itf_map /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map

##Goto Layout Window , Placement ' Core Placement and Optimization .  A new window opens up as shown below . There are various options, you can click on what ever option you want and say ok. The tool will do the placement. Alternatively you can also run at the command at icc_shell . Below is example with congestion option.
get_scan_chains

# places all cells and spreads cells apart that may be in areas of high routing to provide stacks and increase the odds of a successful route later
place_opt -effort high -congestion -area_recovery -power -cts

# conenct the rows to the rings/straps
preroute_standard_cells -nets {VDDA VSS} -connect horizontal -extend_to_boundaries_and_generate_pins

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

### Perform clock optimization
# useful to prevent the upsizing of exisitng clock gates before clustering
cts_prects_upsize_gates 'false'
# prevent moving of existing clock gates prior to clustering
cts_move_clock_gate 'false'


# perform clock tree synthesis as well as other things such as optimization and hold time violation fixing.  Additionally no-route stops actual routing from being performed so that we can see what the clock tree will look like before the routing steps
clock_opt -only_cts -no_clock_route

# perform clock tree synthesis for the given clock and fix all hold time violations
clock_opt -clock_tree ideal_clock -fix_hold_all_clocks -no_clock_route -power

# adjust input and output delay based on the actual clock arrvial times
update_clock_latency

# Perfrom inter clock balancing by performing delay insertation at the clock root. It the clock root net hs a dont buffer exception, icc cannot perform interclock delay 
# balancing. If the clock root is defined as a port of a pad cell the delay insertion is performed on the net driven by the pad cell
balance_inter_clock_delay

# optimize the scan chains by reordering the chains to minimize the number of buffer crossings in the scan chai
# clock_opt -optimze_dft

# run placement and timing optimization
psynopt

# perform detail routing of the clock nets
route_zrt_group -all_clock_nets -reuse_existing_global_route true

# perform clock optimization feasibility analysis after clock_opt
clock_opt_feasibility -only_psyn

# report the actual clock tree synthesis
report_clock_tree -clock_tree [get_clocks ideal_clock] > output/${design}.cts.rpt

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
route_opt -effort high -incremental

# repair any additional problems encountered
route_search_repair -rerun_drc -loop "100"

insert_stdcell_filler -cell_without_metal "FILL8 FILL4 FILL2 FILL" -connect_to_power "VDDA" -connect_to_ground "VSS"

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
report_timing > reports/${route_name}.timing.rpt
report_power > reports/${route_name}.power.rpt
report_drc_error_types > reports/${route_name}.drc.rpt

##POST ROUTE OPTIMIZATION STEPS

##Goto Layout Window, Route -> Verify Route


# define design to extract
set design_extract fpu_extracted

###########################################################################
### Extraction
###########################################################################

##Go to Layout Window, Route -> Extract RC, it opens up a new window as shown below, click ok. Alternatively, you can run this script on the ICC shell:

extract_rc  -coupling_cap  -routed_nets_only  -incremental

##write parasitic to a file for delay calculations tools (e.g PrimeTime).
write_parasitics -output ./output/${design_extract}.spef -format SPEF

##Write Standard Delay Format (SDF) back-annotation file
write_sdf ./output/${design_extract}.sdf

##Write out a script in Synopsys Design Constraints format
write_sdc ./output/${design_extract}.sdc

##Write out a hierarchical Verilog file for the current design, extracted from layout
write_verilog ./output/${design_extract}.v

##Save the cel and report timing
report_timing -max_paths 20 -delay max > reports/${design_extract}.setup.rpt
report_timing -max_paths 20 -delay min > reports/${design_extract}.hold.rpt

save_mw_cel -as ${design_extract}
exit
