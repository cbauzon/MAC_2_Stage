module MAC_nbit #(WIDTH=8, OUT_WIDTH=32)
(
    input clk,
    input rst,
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,

    output logic [OUT_WIDTH-1:0] out
);

    logic [2*WIDTH-1:0] mult_out;
    logic [2*WIDTH-1:0] mult_out_comb;
    logic [OUT_WIDTH-1:0] add_out;
    logic [OUT_WIDTH-1:0] add_out_comb;
    
    // multiply
    always_comb begin
        if (A === {WIDTH{1'bx}} || B === {WIDTH{1'bx}}) begin
            mult_out_comb = 0;
        end else begin
            mult_out_comb = A * B;
        end
    end

    // accumulate
    always_comb begin
        add_out_comb = mult_out + add_out;
    end

    always @(posedge clk, negedge rst) begin
        if (!rst) begin
            mult_out <= 0;
            add_out <= 0;
        end
        else begin
            mult_out <= mult_out_comb;
            add_out <= add_out_comb;
        end
    end

    assign out = add_out;

    /* 
    2-stage pipeline
    input -> multiply -> reg -> accumulate -> reg -> out
    */

endmodule