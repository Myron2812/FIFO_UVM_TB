class fifo_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(fifo_seq_item, fifo_scoreboard) item_got_export;
  `uvm_component_utils(fifo_scoreboard)
  
  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    item_got_export = new("item_got_export", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  bit [`DATA_W-1:0] queue[$];
  
  function void write(input fifo_seq_item item_got);
    bit [`DATA_W-1:0] actualdata;
    if(item_got.i_wren == 1)begin
      queue.push_back(item_got.i_wrdata);
      `uvm_info("write Data", $sformatf("i_wren: %0b o_rddata: %0b i_wrdata: %0d o_empty: %0b o_alm_empty: %0b o_alm_full: %0b o_full: %0b",item_got.i_wren, item_got.o_rddata, item_got.i_wrdata, item_got.o_empty, item_got.o_alm_empty, item_got.o_alm_full, item_got.o_full), UVM_LOW);
    end
    if (item_got.i_rden == 1)begin
      if(queue.size() >= 1)begin
        actualdata = queue.pop_front();
        `uvm_info("Read Data", $sformatf("actualdata: %0d o_rddata: %0d o_empty: %0b o_alm_empty: %0b o_alm_full: %0b o_full: %0b", actualdata, item_got.o_rddata, item_got.o_empty, item_got.o_alm_empty, item_got.o_alm_full, item_got.o_full), UVM_LOW);
        if(actualdata == item_got.o_rddata)begin
          $display("match");
        end
        else begin
          $display("mismatch");
          $display("check for empty flag");
        end
      end
    end
  endfunction
endclass
        

