VLOG =  /tools/mentor/questasim/questasim/bin/vlog

VSIM = /tools/mentor/questasim/questasim/bin/vsim

all: comp_rtl comp run

comp_rtl:
	$(VLOG) +cover=bcstfex fifo.sv

comp: 
	$(VLOG) +incdir+/home/myrondcunha/Downloads/uvm-1.1d/src \
 /home/myrondcunha/Downloads/uvm-1.1d/src/uvm_pkg.sv +define+UVM_NO_DPI fifo_top.sv  

run: 
	$(VSIM)   -coverage  -novopt tb +UVM_TESTNAME=fifo_test -l vsim.log -c
       ##add wave -r
