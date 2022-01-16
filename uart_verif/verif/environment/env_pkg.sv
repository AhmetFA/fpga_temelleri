`ifndef env_pkg
`define env_pkg

package env_pkg;
   
   import uvm_pkg::*;
   `include "uvm_macros.svh"

   //////////////////////////////////////////////////////////
   // importing packages : uart_agent
   /////////////////////////////////////////////////////////
   import uart_agent_pkg::*;

   //////////////////////////////////////////////////////////
   // include top env files 
   /////////////////////////////////////////////////////////
  `include "environment.sv"

endpackage
`endif