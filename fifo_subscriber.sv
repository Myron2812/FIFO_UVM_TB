class fifo_subscriber extends uvm_subscriber #(fifo_seq_item);
  uvm_analysis_imp #(fifo_seq_item, fifo_subscriber) cov_exp;
    `uvm_component_utils(fifo_subscriber)
    fifo_seq_item fifo_item;
    fifo_seq_item fifo_queue[$];

    covergroup cg_en;
	option.per_instance = 1;
        covg_i_wren      : coverpoint fifo_item.i_wren;  
        covg_i_rden      : coverpoint fifo_item.i_rden;
        covg_i_wrdata    : coverpoint fifo_item.i_wrdata;
        covg_o_rddata    : coverpoint fifo_item.o_rddata;
    endgroup: cg_en

    covergroup cg_write;
	option.per_instance = 1;
	option.auto_bin_max = 1024;
	covg_i_wrdata : coverpoint fifo_item.i_wrdata;
    endgroup

    covergroup cg_read;
        option.per_instance = 1;
	option.auto_bin_max = 1024;
	covg_o_rddata : coverpoint fifo_item.o_rddata;
    endgroup
        
    function new(string name, uvm_component parent);
        super.new(name, parent);
        cov_exp = new("cov_exp",this);
        cg_en = new();
	cg_write = new();
	cg_read = new();
    endfunction: new

  function void write(fifo_seq_item t);
        fifo_queue.push_front(t);
    endfunction: write
  
	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
       `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
        forever begin
	      fifo_item = fifo_seq_item::type_id::create("fifo_item",this);
          wait(fifo_queue.size!=0);
	     	fifo_item  = fifo_queue.pop_back();
    cg_en.sample();
	cg_write.sample();
	cg_read.sample();
        end 
    endtask :run_phase

    virtual function void extract_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Coverage for enables : %f\nWrite Coverage : %f\nRead Coverage : %f", cg_en.get_inst_coverage(),cg_write.get_inst_coverage(),cg_read.get_inst_coverage()), UVM_LOW)    endfunction: extract_phase

endclass: fifo_subscriber

