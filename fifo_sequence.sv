class fifo_sequence extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_sequence)
  
  function new(string name = "fifo_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    
    `uvm_info(get_type_name(), $sformatf("******** Generate Write REQs ********"), UVM_LOW)
    repeat(250) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {{i_wren,i_rden} == 2'b10;});
      finish_item(req);
    end
    
    `uvm_info(get_type_name(), $sformatf("******** Generate Read REQs ********"), UVM_LOW)
    repeat(250) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {{i_wren,i_rden} == 2'b01;});
      finish_item(req);
    end
    
//     `uvm_info(get_type_name(), $sformatf("******** Generate a few write REQs ********"), UVM_LOW)
//     repeat(25) begin
//       req = fifo_seq_item::type_id::create("req");
//       start_item(req);
//       assert(req.randomize() with {{i_wren,i_rden} == 2'b10;});
//       finish_item(req);
//     end
    
//     `uvm_info(get_type_name(), $sformatf("******** Generate Simultaneous Read&Write REQs ********"), UVM_LOW)
//     repeat(50) begin
//       req = fifo_seq_item::type_id::create("req");
//       start_item(req);
//       assert(req.randomize() with {{i_wren,i_rden} == 2'b11;});
//       finish_item(req);
//     end
    
//     `uvm_info(get_type_name(), $sformatf("******** Generate No Read&Write REQs ********"), UVM_LOW)
//     repeat(10) begin
//       req = fifo_seq_item::type_id::create("req");
//       start_item(req);
//       assert(req.randomize() with {{i_wren,i_rden} == 2'b00;});
//       finish_item(req);
//     end
    
//     `uvm_info(get_type_name(), $sformatf("******** Generate Random REQs ********"), UVM_LOW)
//     repeat(100) begin
//       req = fifo_seq_item::type_id::create("req");
//       start_item(req);
//       assert(req.randomize());
//       finish_item(req);
//     end
   endtask
  
endclass
