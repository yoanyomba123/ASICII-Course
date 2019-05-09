#!/bin/bash

# execute source sensei
source ~/sensei

cd dc_synth

# remove everything present in reports directory
rm -rf reports/*

# as well as logs
rm -rf logs/*

dc_shell -f dc_synth.tcl

cat reports/synth_area.rpt
cat reports/synth_cells.rpt
cat reports/synth_power.rpt
cat reports/synth_qor.rpt

# run pt_pre 
cd ../pt_pre
pt_shell -f pt_pre.tcl

# run pt_pre reports
cd reports
grep -i "slack" timing.rpt > timing.log
# print out the slack values
cat timing.log 

#cd ../../icc_pnr 
#icc_shell -f scripts/init_design.tcl
#icc_shell -f scripts/floorplan.tcl
#icc_shell -f scripts/cts_icc.tcl
#icc_shell -f scripts/route.tcl
#icc_shell -f scripts/extract.tcl

