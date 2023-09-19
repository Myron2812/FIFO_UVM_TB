class fifo_seq_item extends uvm_sequence_item;
  
  //inputs
  
  rand bit i_wren; //write enable
  rand bit i_rden; //read enable
  rand bit [`DATA_W-1:0] i_wrdata;
  
  //outputs
  
  bit [`DATA_W-1:0] o_rddata;
  bit o_full;
  bit o_alm_full;
  bit o_alm_empty;
  bit o_empty;
  
  //field macros
  
  `uvm_object_utils_begin(fifo_seq_item)
  `uvm_field_int(i_wren,UVM_ALL_ON)
  `uvm_field_int(i_rden,UVM_ALL_ON)
  `uvm_field_int(i_wrdata,UVM_ALL_ON)
  `uvm_field_int(o_rddata,UVM_ALL_ON)
  `uvm_field_int(o_full,UVM_ALL_ON)
  `uvm_field_int(o_alm_full,UVM_ALL_ON)
  `uvm_field_int(o_alm_empty,UVM_ALL_ON)
  `uvm_field_int(o_empty,UVM_ALL_ON)
  `uvm_object_utils_end
  
  //class constructor
  
  function new(string name="fifo_seq_item");
    super.new(name);
  endfunction
  
  //constraints
  
endclass

/*module tb;
  fifo_seq_item seq_item;
  initial begin
    seq_item = fifo_seq_item::type_id::create(); 
    seq_item.randomize();
    seq_item.print();   
  end  
endmodule*///test if sequence items are generated

