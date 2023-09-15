module FIFO(clk, rstn, i_wrdata, i_wren, i_rden, o_full, o_alm_full, o_alm_empty, o_empty, o_rddata);
  parameter ADDRESS = 10, DATA_W = 128, DEPTH = 1024, UPP_TH = 4, LOW_TH = 2;
  
  input clk, rstn, i_wren, i_rden;
  input [DATA_W-1:0] i_wrdata;
  output reg o_full, o_alm_full, o_alm_empty, o_empty;
  output reg [DATA_W-1:0] o_rddata;
  
  reg [ADDRESS-1:0] wrptr, rdptr;
  reg [DATA_W-1:0] memory [DEPTH-1:0];
  reg [ADDRESS-1:0] count;
 
  assign o_full = (count == DEPTH-1);
  assign o_alm_full = (count >= DEPTH - UPP_TH);
  assign o_alm_empty = (count <= LOW_TH);
  assign o_empty = (count == 0);
  
  always@(posedge clk)begin
    if(rstn == 1)begin
      wrptr <= 0;
      rdptr <= 0;
      o_rddata <= 0;
      foreach (memory[i,j])
        memory[i][j] <= 0;
    end
    else begin
      if(i_wren == 1 && o_full != 1)begin
        memory[wrptr] <= i_wrdata;
        wrptr <= wrptr + 1;
      end
      if(i_rden == 1 && o_empty!= 1)begin
        o_rddata <= memory[rdptr];
        rdptr <= rdptr + 1;
      end
      count = wrptr - rdptr;
    end
  end
endmodule