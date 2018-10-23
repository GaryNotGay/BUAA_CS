`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:54:33 07/16/2018 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
	 input reset,
	 input MemWrite,
	 input [31:0] IR_In,
	 input [31:0] PC_Out,
	 input [31:0] ALU_Out,
	 input [31:0] WD,	 
	 output [31:0] DM_Out
    );
	 
	 reg [31:0] RAM [1023:0];
	 integer i;
	 wire [9:0] Addr;
	 wire [31:0] Addr_Out;
	 
	 initial begin
	    for(i = 0; i < 1024; i = i + 1)
		    RAM[i] = 32'h00000000;
	 end
	 
	 assign Addr = ALU_Out[11:2];
	 assign DM_Out = (IR_In[31:26] == 2'b000011) ? (PC_Out + 4) : RAM[Addr];
	 assign Addr_Out = {20'b0, Addr, 2'b0};
	 
	 always @ (posedge clk) begin
	    		 
		 if (reset) begin
		    for(i = 0; i < 1024; i = i + 1)
			    RAM[i] <= 32'h00000000;
		 end
		 
		 else if (MemWrite) begin
		    RAM[Addr] <= WD;
			 $display("%d@%h: *%h <= %h", $time, PC_Out, Addr_Out, WD);
		 end
		 
	 end
		 
endmodule
