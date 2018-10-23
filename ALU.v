`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:36:41 07/16/2018 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
	 input [2:0] ALUOp,
	 output reg [31:0] ALU_Out
    );
	 
	 initial begin
	    ALU_Out = 32'h00000000;
	 end
	 
	 always @ (*) begin
	    
		 case(ALUOp)
		 
		    3'b000: ALU_Out <= A + B;
          
          3'b001: ALU_Out <= A - B;
			 
			 3'b010: ALU_Out <= A | B;
			 
			 3'b011: ALU_Out <= B;
			 
			 3'b100: ALU_Out <= A;
		 
			 3'b101: begin
			    if(B[7] == 1)
				    ALU_Out <= {24'hffffff, B[7:0]};
				 else
				    ALU_Out <= {24'h000000, B[7:0]};
			 end			 
			 
			 
		 endcase
		 
	 end
			  			 
endmodule
