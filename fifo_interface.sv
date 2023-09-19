interface fifo_interface(input clk, rstn);
  bit i_wren;
  bit i_rden;
  bit [`DATA_W-1:0] i_wrdata;
  bit o_full;
  bit o_alm_full;
  bit o_alm_empty;
  bit o_empty;
  bit [`DATA_W-1:0] o_rddata;
  
  clocking d_cb @(posedge clk);
    default input #1 output #1;
    output i_wren;
    output i_rden;
    output i_wrdata;
    input o_full;
    input o_alm_full;
    input o_alm_empty;
    input o_empty;
    input o_rddata;
  endclocking
  
  clocking m_cb @(posedge clk);
    default input #1 output #1;
    input i_wren;
    input i_rden;
    input i_wrdata;
    input o_full;
    input o_alm_full;
    input o_alm_empty;
    input o_empty;
    input o_rddata;
  endclocking
  
  modport d_mp (input clk, rstn, clocking d_cb);
  modport m_mp (input clk, rstn, clocking m_cb);
    
endinterface

