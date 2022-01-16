`ifndef uart_agent_pkg
`define uart_agent_pkg

package uart_agent_pkg;
 
   import uvm_pkg::*;
   `include "uvm_macros.svh"

   //////////////////////////////////////////////////////////
   // include Agent components : driver,monitor,sequencer
   /////////////////////////////////////////////////////////
   `include "uart_transaction.sv"
   `include "uart_sequencer.sv"
   `include "uart_driver.sv"
   //`include "uart_monitor.sv"
   `include "uart_agent.sv"

endpackage

`endif
