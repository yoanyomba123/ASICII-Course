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
create_floorplan -control_type aspect_ratio -core_aspect_ratio "1" -core_utilization 0.6 -start_first_row -left_io2core 15 -bottom_io2core 15 -right_io2core 15 -top_io2core 15

derive_pg_connection -power_net VDDA -ground_net VSS
derive_pg_connection -power_net VDDA -ground_net VSS -tie
# create power rings around the edge
create_rectilinear_rings -nets {VDDA VSS} -offset {1 1} -width {3 3} -space {3 3}

##Create VSS ring
create_rectangular_rings  -nets  {VSS}  -left_offset 0.5  -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 0.5 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 0.5  -bottom_segment_layer  M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 0.5 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th
 
## Create VDDa Ring
create_rectangular_rings  -nets  {VDDA}  -left_offset 1.8  -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 1.8 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 1.8  -bottom_segment_layer M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 1.8 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th

## Creates Power Strap 
set_preroute_advanced_via_rule -move_via_to_center
create_power_straps -nets { VDDA } -layer M6 -direction vertical -width 3 -advanced_via_rules
create_power_straps -nets { VSS } -layer M6 -direction vertical  -width 3
#create_fp_placement -num_cpus 16
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
create_fp_placement -timing_driven -no_hierarchy_gravity -num_cpus 16

## Generate the floorplan power rails
#synthesize_fp_rail 
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
exit
