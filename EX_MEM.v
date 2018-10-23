`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:47:09 07/16/2018 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
    input clk,
    input reset,
	 input EX_MEM_En,
	 input [31:0] IR_In,
	 input [31:0] RD2_In,
	 input [31:0] PC_Out_In,
	 input [31:0] ALU_Out_In,
	 output [31:0] IR_Out,
	 output [31:0] RD2_Out,
	 output [31:0] PC_Out_Out,
	 output [31:0] ALU_Out_Out
    );
	 
	 reg [31:0] IR;
	 reg [31:0] RD2;
	 reg [31:0] PC;
	 reg [31:0] ALU_Out;
	 
	 assign IR_Out = IR;
	 assign RD2_Out = RD2;
	 assign PC_Out_Out = PC;
	 assign ALU_Out_Out = ALU_Out;
    
	 initial begin
	    IR = 32'h00000000;
		 RD2 = 32'h00000000;
		 PC = 32'h00000000;
		 ALU_Out = 32'h00000000;
	 end
	 
	 always @ (posedge clk) begin
	    
		 if (reset) begin
		    IR <= 0;
			 RD2 <= 0;
			 PC <= 0;
			 ALU_Out <= 0;
		 end
		 
		 else begin
		    IR <= IR_In;
			 RD2 <= RD2_In;
			 PC <= PC_Out_In;
			 ALU_Out <= ALU_Out_In;
		 end
		 
	 end

endmodule
