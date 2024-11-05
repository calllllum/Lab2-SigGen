module sigdelay #(
    parameter A_WIDTH = 9,
              D_WIDTH = 8
)(
    //interface signals
    input logic         clk,
    input logic         rst,
    input logic         wr,
    input logic         rd,
    input logic [A_WIDTH-1:0] offset,
    input logic [D_WIDTH-1:0] mic_signal,
    output logic [D_WIDTH-1:0] delayed_signal
);
    logic [A_WIDTH-1:0]     r_address;
    logic [A_WIDTH-1:0]     w_address;
    assign r_address = w_address + offset;

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .count (w_address)
);

ram dualram(
    .clk (clk),
    .rd_en (rd),
    .wr_en (wr), 
    .rd_addr (r_address),
    .wr_addr (w_address),
    .din  (mic_signal),
    .dout (delayed_signal)
);

endmodule
