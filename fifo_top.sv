import uvm_pkg::*;
`include "defines.sv"
`include "uvm_macros.svh"
`include "fifo_interface.sv"
`include "fifo_test.sv"
//`include "mydesign.sv"
`include "fifo.sv"

module tb;
  bit clk;
  bit rstn;
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 1;
    rstn = 0;
    #5;
    rstn = 1;
  end
  
  fifo_interface tif(clk, rstn);
  
  my_fifo dut(.clk(tif.clk),
               .rstn(tif.rstn),
               .i_wrdata(tif.i_wrdata),
               .i_wren(tif.i_wren),
               .i_rden(tif.i_rden),
               .o_full(tif.o_full),
               .o_alm_full(tif.o_alm_full),
               .o_alm_empty(tif.o_alm_empty),
               .o_empty(tif.o_empty),
               .o_rddata(tif.o_rddata));
  
  initial begin
    uvm_config_db#(virtual fifo_interface)::set(null, "", "vif", tif);
    $dumpfile("dump.vcd"); 
    $dumpvars;
    run_test("fifo_test");
    $finish;
  end
  
endmodule

