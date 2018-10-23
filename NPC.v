`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:38:35 07/16/2018 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input Branch,
    input Zero,
	 input Bgezalr,
    input [1:0] Jump,
	 input [31:0] RD1,
	 input [31:0] RD2,
	 input [31:0] EXT_Out,
	 input [31:0] PC_Out, 
	 input [31:0] PC_D,
	 output [31:0] PC_Next
    );
	 
	 reg [31:0] PC;
	 assign PC_Next = PC;
	 
	 always @ (*) begin
	    
		 if (!Branch) //PC + 4
		    PC <= PC_Out + 4;
		 
       else if (Branch & Zero & (Jump == 2'b00)) // beq
			 PC <= PC_D + 4 + EXT_Out;
			 
		 else if(Branch & (Jump == 2'b01)) //J Jal
		    PC <= {PC_D[31:28], EXT_Out[27:0]};
		 
		 else if(Branch & (Jump == 2'b10)) //Jr
		    PC <= RD1;
			 
		 else if(Branch & (Jump == 2'b11) & Bgezalr) //Bgezalr
		    PC <= RD2;
		 
		 else //PC + 4
		    PC <= PC_Out + 4;

    end
	 
endmodule
