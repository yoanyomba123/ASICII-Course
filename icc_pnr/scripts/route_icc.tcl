# define the given design rout
set route_name fpu_route

###########################################################################
### Routing
###########################################################################

##In the layout window, click on Route -> Core Routing and Optimization

route_opt 

##Save the cel and report timing

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


