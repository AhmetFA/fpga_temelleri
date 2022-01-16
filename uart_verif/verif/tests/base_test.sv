`ifndef base_test
`define base_test

`include "uvm_macros.svh"

class base_test extends uvm_test;
 
  ////////////////////////////////////////////////////////////////////
  //declaring component utils for the basic test-case 
  ////////////////////////////////////////////////////////////////////
  `uvm_component_utils(base_test)
 
  environment    env;
  uart_write_seq wr_seq;

  ////////////////////////////////////////////////////////////////////
  // Method name : new
  // Decription: Constructor 
  ////////////////////////////////////////////////////////////////////
  function new(string name = "base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  ////////////////////////////////////////////////////////////////////
  // Method name : build_phase 
  // Decription: Construct the components and objects 
  ////////////////////////////////////////////////////////////////////
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    env = environment::type_id::create("env", this);
    wr_seq = uart_write_seq::type_id::create("seq");
  endfunction : build_phase
  ////////////////////////////////////////////////////////////////////
  // Method name : run_phase 
  // Decription: Trigger the sequences to run 
  ////////////////////////////////////////////////////////////////////
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
        #1us;
        wr_seq.sw = 4;

        for (int i =0; i < 256; i++) begin
            wr_seq.uart_stim_data = i; 
            wr_seq.start(env.uart_agnt.sequencer);
        end

        #30ms;
    phase.drop_objection(this);
  endtask : run_phase
 
endclass : base_test
`endif