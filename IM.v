`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:24:56 07/12/2018 
// Design Name: 
// Module Name:    IM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IM(
    input [31:0] PC_Out,
    output [31:0] IM_Out
    );
	 
	 wire [9:0] Addr;
	 reg [31:0] ROM [0:1023];
	 
	 initial begin
	    $readmemh("code.txt", ROM); 
	 end
	 
	 assign Addr = PC_Out[11:2];
	 assign IM_Out = (PC_Out[15:12] == 2'b0011) ? ROM[Addr] : 32'h00000000;

endmodule
