`ifndef uart_agent 
`define uart_agent

class uart_agent extends uvm_agent;
  ///////////////////////////////////////////////////////////////////////////////
  // Declaration of UVC components such as.. driver,monitor,sequencer..etc
  ///////////////////////////////////////////////////////////////////////////////
  uart_driver    driver;
  uart_sequencer sequencer;
  //uart_monitor   monitor;
  
  ///////////////////////////////////////////////////////////////////////////////
  // Declaration of component utils 
  ///////////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(uart_agent)
  ///////////////////////////////////////////////////////////////////////////////
  // Method name : new 
  // Description : constructor
  ///////////////////////////////////////////////////////////////////////////////
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  ///////////////////////////////////////////////////////////////////////////////
  // Method name : build-phase 
  // Description : construct the components such as.. driver,monitor,sequencer..etc
  ///////////////////////////////////////////////////////////////////////////////
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver = uart_driver::type_id::create("driver", this);
    sequencer = uart_sequencer::type_id::create("sequencer", this);
    //monitor = uart_monitor::type_id::create("monitor", this);
  endfunction : build_phase
  ///////////////////////////////////////////////////////////////////////////////
  // Method name : connect_phase 
  // Description : connect tlm ports ande exports (ex: analysis port/exports) 
  ///////////////////////////////////////////////////////////////////////////////
  function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction : connect_phase
 
endclass : uart_agent

`endif