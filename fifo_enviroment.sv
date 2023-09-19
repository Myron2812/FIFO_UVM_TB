`include "fifo_agent.sv"
`include "fifo_scoreboard.sv"
`include "fifo_subscriber.sv"

class fifo_enviroment extends uvm_env;
  fifo_agent f_agt;
  fifo_scoreboard f_scb;
  fifo_subscriber f_sub;
  `uvm_component_utils(fifo_enviroment)
  
  function new(string name = "fifo_enviroment", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    f_agt = fifo_agent::type_id::create("f_agt", this);
    f_scb = fifo_scoreboard::type_id::create("f_scb", this);
    f_sub = fifo_subscriber::type_id::create("f_sub",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    f_agt.f_mon.item_got_port.connect(f_scb.item_got_export);
    f_agt.f_mon.item_got_port.connect(f_sub.cov_exp);
  endfunction
  
endclass

