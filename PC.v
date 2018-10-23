`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:50 07/12/2018 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input reset,
	 input PC_En,
	 input [31:0] PC_Next,
    output reg [31:0] PC_Out
    );

    initial begin
	    PC_Out <= 32'h00003000;
    end
	 
	 always @ (posedge clk) begin
	 
	    if(reset == 1)
		    PC_Out <= 32'h00003000;
		 
		 else if(PC_En == 1)
		    PC_Out <= PC_Next;
    
	 end			 
		    
endmodule
