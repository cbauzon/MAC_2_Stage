interface mac_intf(input clk);
    logic rst;
    logic [7:0] A;
    logic [7:0] B;

    logic [31:0] out;
endinterface