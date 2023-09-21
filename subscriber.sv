class fifo_coverage extends uvm_subscriber #(fifo_seq_item);
    `uvm_component_utils(fifo_coverage)
    fifo_seq_item pkt;
    int i;

    covergroup cg_en;
	option.per_instance = 1;
        covg_i_wren      : coverpoint pkt.i_wren;  
        covg_i_rden      : coverpoint pkt.i_rden;
        covg_i_wrdata    : coverpoint pkt.i_wrdata;
        covg_o_rddata    : coverpoint pkt.o_rddata;
    endgroup: cg_en

    covergroup cg_write;
	option.per_instance = 1;
	option.auto_bin_max = 1024;
	covg_i_wrdata : coverpoint pkt.i_wrdata;
    endgroup

    covergroup cg_read;
        option.per_instance = 1;
	option.auto_bin_max = 1024;
	covg_o_rddata : coverpoint pkt.o_rddata;
    endgroup
        
    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg_en = new();
	cg_write = new();
	cg_read = new();
    endfunction: new

  function void write(fifo_seq_item t);
        pkt = t;
        i++;
        cg_en.sample();
	cg_write.sample();
	cg_read.sample();
    endfunction: write

    virtual function void extract_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Coverage for enables : %f\nWrite Coverage : %f\nRead Coverage : %f", cg_en.get_inst_coverage(),cg_write.get_inst_coverage(),cg_read.get_inst_coverage()), UVM_LOW)
    endfunction: extract_phase

endclass: fifo_coverage
