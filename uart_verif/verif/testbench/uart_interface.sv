`ifndef uart_interface
`define uart_interface
interface uart_interface(input logic clock,reset);

logic [2:0] sw;
logic       rx_din;
logic       tx_dout;
logic       tx_active;
logic       rx_active;

endinterface
`endif