class fifo_subscriber extends uvm_subscriber #(fifo_seq_item);
  uvm_analysis_imp #(fifo_seq_item, fifo_subscriber) cov_exp;
    `uvm_component_utils(fifo_subscriber)
    fifo_seq_item fifo_item;
    fifo_seq_item fifo_queue[$];

    covergroup cg;
	option.per_instance = 1; 
        cov_i_wren_p : coverpoint fifo_item.i_wren {
            bins i_wren_1   = {1'b1}; 
            bins i_wren_0   = {1'b0};
        }
        cov_i_rden_p : coverpoint fifo_item.i_rden {
            bins i_rden_1 = {1'b1}; 
            bins i_rden_0 = {1'b0};
        }
        cov_o_full_p  : coverpoint fifo_item.o_full {
            bins o_full_1 = {1'b1}; 
            bins o_full_0 = {1'b0};
        }
        cov_o_alm_full_p  : coverpoint fifo_item.o_alm_full {
            bins o_alm_full_1 = {1'b1}; 
            bins o_alm_full_0 = {1'b0};
        }
        cov_o_alm_empty_p  : coverpoint fifo_item.o_alm_empty {
            bins o_alm_empty_1 = {1'b1}; 
            bins o_alm_empty_0 = {1'b0};
        }
        cov_empty_p  : coverpoint fifo_item.o_empty {
            bins o_empty_1 = {1'b1}; 
            bins o_empty_0 = {1'b0};
        } 

        cross cov_i_wren_p, cov_i_rden_p {
            bins wr_i_rden_00 = binsof(cov_i_wren_p) intersect {1'b0} && binsof(cov_i_rden_p) intersect {1'b0};
            bins wr_i_rden_10 = binsof(cov_i_wren_p) intersect {1'b1} && binsof(cov_i_rden_p) intersect {1'b0};
            bins wr_i_rden_01 = binsof(cov_i_wren_p) intersect {1'b0} && binsof(cov_i_rden_p) intersect {1'b1};
            bins wr_i_rden_11 = binsof(cov_i_wren_p) intersect {1'b1} && binsof(cov_i_rden_p) intersect {1'b1};
        }
    endgroup
        
    function new(string name, uvm_component parent);
        super.new(name, parent);
        cov_exp = new("cov_exp",this);
        cg = new();
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
	    cg.sample();  
        end 
    endtask :run_phase

    virtual function void extract_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Coverage : %f", cg.get_coverage()), UVM_LOW)
    endfunction: extract_phase

endclass: fifo_subscriber
