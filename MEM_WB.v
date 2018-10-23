`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:22:21 07/16/2018 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
    input clk,
	 input reset,
	 input MEM_WB_En,
    input [31:0] IR_In,
    input [31:0] ALU_Out_In,
    input [31:0] DM_Out_In,
	 input [31:0] PC_Out_In,
    output [31:0] IR_Out,
    output [31:0] ALU_Out_Out,
    output [31:0] DM_Out_Out,
	 output [31:0] PC_Out_Out
    );
	 
	 reg [31:0] IR;
	 reg [31:0] ALU_Out;
	 reg [31:0] DM_Out;
	 reg [31:0] PC_Out;
	 
	 assign IR_Out = IR;
	 assign ALU_Out_Out = ALU_Out;
	 assign DM_Out_Out = DM_Out;
	 assign PC_Out_Out = PC_Out;
	 
	 initial begin
	    IR <= 32'h00000000;
		 ALU_Out <= 32'h00000000;
		 DM_Out <= 32'h00000000;
		 PC_Out <= 32'h00000000;
	 end
	 
	 always @ (posedge clk) begin
	  
	    if (reset) begin
		    IR <= 32'h00000000;
			 ALU_Out <= 32'h00000000;
			 DM_Out <= 32'h00000000;
			 PC_Out <= 32'h00000000;
		 end
		 
		 else begin
		    IR <= IR_In;
			 ALU_Out <= ALU_Out_In;
			 DM_Out <= DM_Out_In;
			 PC_Out <= PC_Out_In;
		 end
		 
	 end
	 
endmodule
