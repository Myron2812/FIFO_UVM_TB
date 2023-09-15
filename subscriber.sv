class fifo_coverage extends uvm_subscriber #(fifo_seq_item);
    `uvm_component_utils(fifo_coverage)
    fifo_seq_item pkt;
    int i;

    covergroup cg;
        covg_i_wren      : coverpoint pkt.i_wren;  
        covg_i_rden      : coverpoint pkt.i_rden;
        covg_i_wrdata    : coverpoint pkt.i_wrdata;
        covg_o_rddata    : coverpoint pkt.o_rddata;
    endgroup: cg
        
    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg = new();
    endfunction: new

  function void write(fifo_seq_item t);
        pkt = t;
        i++;
        cg.sample();
    endfunction: write

    virtual function void extract_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Coverage : %f", cg.get_coverage()), UVM_LOW)
    endfunction: extract_phase

endclass: fifo_coverage
