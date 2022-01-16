module AL (
input  logic clock,
input  logic reset,
input  logic [2:0] sw,
input  logic rx_din,
output logic tx_dout,
output logic tx_active,
output logic rx_active
);

    top #(
    .osc_freq(100_000_000),
    .Data_width(8),
    .no_of_sample(16)
    )
    DUT( 
    .clock(clock),
    .reset(reset),
    .sw(sw),
    .rx_din(rx_din),
    .tx_dout(tx_dout),
    .tx_active(tx_active),
    .rx_active(rx_active)
    );
  end top;

endmodule