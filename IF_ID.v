`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:04 07/12/2018 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
    input clk,
    input reset,
    input IF_ID_En,
	 input [31:0] IR_In, 
	 input [31:0] PC_Out_In,
	 output [31:0] IR_Out,
	 output [31:0] PC_Out_Out
    );
	 
	 reg [31:0] IF_ID_IR;
	 reg [31:0] IF_ID_PC;
	 
	 assign IR_Out = IF_ID_IR;
	 assign PC_Out_Out = IF_ID_PC;
	 
	 initial begin
       IF_ID_IR = 0;
		 IF_ID_PC = 0;
	 end
	 
	 always @ (posedge clk) begin
	    
		 if (reset) begin
		    IF_ID_IR <= 0;
			 IF_ID_PC <= 0;
		 end
		 
		 else if (IF_ID_En == 1) begin
		    IF_ID_IR <= IR_In;
			 IF_ID_PC <= PC_Out_In;
		 end
		 
	 end
	 
endmodule
