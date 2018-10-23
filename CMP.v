`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:41 07/16/2018 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] RD1,
    input [31:0] RD2,
	 output Zero,
	 output Bgezalr
    );
	 
	 assign Zero = (RD1 == RD2) ? 1 : 0;
    assign Bgezalr = (RD1[31] == 1) ? 0 : 1;
endmodule
