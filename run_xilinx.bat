@echo off

set XVKMA_CORE_LUT_PACK=TRUE
set XIL_PAR_MAX_PLOAD=100
set XIL_GUIDE_CONNECTRPT=1
set XIL_MAP_OLD_SAVE=1

ngdbuild -sd . -sd ..\synthesis -uc .\2s050pq208_32_33.ucf pcim_top

map -pr b pcim_top.ngd -o pcim_top.ncd pcim_top.pcf

par -ol high -w pcim_top.ncd pcim_top_routed pcim_top.pcf

trce -v 10 pcim_top_routed.ncd pcim_top.pcf

netgen -ofmt verilog -w pcim_top_routed.ncd

bitgen -w -g startupclk:cclk pcim_top_routed.ncd bitstream_cclk pcim_top.pcf
promgen -p mcs -x xcf32p -c 0xFF -w -o bitstream_cclk.mcs -u 0 bitstream_cclk.bit
