`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:54:15 07/15/2018 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
    input clk,
	 input reset,
	 input ID_EX_Clr,
	 input [31:0] IR_In,
	 input [31:0] PC_Out_In,
	 input [31:0] RD1_In,
	 input [31:0] RD2_In,
	 input [31:0] EXT_In,
	 output [31:0] IR_Out,
	 output [31:0] PC_Out_Out,
	 output [31:0] RD1_Out,
	 output [31:0] RD2_Out,
	 output [31:0] EXT_Out
    );
	 
	 reg [31:0] IR;
	 reg [31:0] PC;
	 reg [31:0] RD1;
	 reg [31:0] RD2;
	 reg [31:0] EXT;
	 
	 assign IR_Out = IR;
	 assign PC_Out_Out = PC;
	 assign RD1_Out = RD1;
	 assign RD2_Out = RD2;
	 assign EXT_Out = EXT;
	 
	 initial begin
	    IR = 32'h00000000;
		 PC = 32'h00000000;
		 RD1 = 32'h00000000;
		 RD2 = 32'h00000000;
		 EXT = 32'h00000000;
	 end
	 
	 always  @ (posedge clk) begin
	    
		 if (reset == 1) begin
		    IR <= 32'h00000000;
			 PC <= 32'h00000000;
		    RD1 <= 32'h00000000;
		    RD2 <= 32'h00000000;
		    EXT <= 32'h00000000;
		 end
		 
		 else if (ID_EX_Clr == 1) begin
		    IR <= 32'h00000000;
			 PC <= 32'h00000000;
		    RD1 <= 32'h00000000;
		    RD2 <= 32'h00000000;
		    EXT <= 32'h00000000;
		 end
		 
		 else begin
		    IR <= IR_In;
			 PC <= PC_Out_In;
			 RD1 <= RD1_In;
			 RD2 <= RD2_In;
			 EXT <= EXT_In;
		 end
		 
	 end
			 
endmodule
