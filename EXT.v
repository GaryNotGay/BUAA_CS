`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:27:01 07/15/2018 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [2:0] EXTOp,
    input [31:0] IR_In, 
	 input [31:0] RD2,
	 output reg [31:0] EXT_Out
    );
	 
	 initial begin
	    EXT_Out <= 32'h00000000;
	 end
	 
	 always @ (*) begin
	 
	    case(EXTOp)
		    
			 3'b000: EXT_Out <= {16'h0000, IR_In[15:0]};
			 
			 3'b001: EXT_Out <= {IR_In[15:0], 16'h0000};
			 
			 3'b010: begin
			    if(IR_In[13] == 1)
				    EXT_Out <= {16'hffff, IR_In[13:0], 2'b00};
				 else
				    EXT_Out <= {16'h0000, IR_In[13:0], 2'b00};
			 end
			 
			 3'b011: begin
			    if(IR_In[15] == 1)
				    EXT_Out <= {16'hffff, IR_In[15:0]};
				 else
				    EXT_Out <= {16'h0000, IR_In[15:0]};
			 end
			 
			 3'b100: EXT_Out <= {4'b0000, IR_In[25:0], 2'b00};

       
		 endcase
		 
	 end

endmodule
