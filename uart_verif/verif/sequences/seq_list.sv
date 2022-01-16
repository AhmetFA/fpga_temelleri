`ifndef seq_list 
`define seq_list

package seq_list;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import uart_agent_pkg::*;
    import env_pkg::*;

    //////////////////////////////////////////////////////////////////////////////
    // including sequence list
    //////////////////////////////////////////////////////////////////////////////

    `include "uart_write_seq.sv"

endpackage

`endif
