`ifndef environment
`define environment

class environment extends uvm_env;
 
  //////////////////////////////////////////////////////////////////////////////
  //Declaration components
  //////////////////////////////////////////////////////////////////////////////
  uart_agent uart_agnt;
   
  //////////////////////////////////////////////////////////////////////////////
  //Declaration of component utils to register with factory
  //////////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(environment)
     
  //////////////////////////////////////////////////////////////////////////////
  // Method name : new 
  // Description : constructor
  //////////////////////////////////////////////////////////////////////////////
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  //////////////////////////////////////////////////////////////////////////////
  // Method name : build_phase 
  // Description : constructor
  //////////////////////////////////////////////////////////////////////////////
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uart_agnt = uart_agent::type_id::create("uart_agnt", this);
  endfunction : build_phase
  //////////////////////////////////////////////////////////////////////////////
  // Method name : build_phase 
  // Description : constructor
  //////////////////////////////////////////////////////////////////////////////
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

  endfunction : connect_phase

endclass : environment

`endif