`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:16 07/15/2018 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input reset,
	 input RegWrite,
	 input [4:0] WA,
	 input [31:0] RegData,
	 input [31:0] PC_Out,
	 input [31:0] IR_In,
	 output [31:0] RD1,
	 output [31:0] RD2
    );
	 
	 wire [4:0] RA1;
	 wire [4:0] RA2;
	 
	 assign RA1 = IR_In[25:21];
	 assign RA2 = IR_In[20:16];
	 
	 assign RD1 = (WA == IR_In[25:21] & WA != 0 & RegWrite) ? RegData : Reg[RA1];
	 assign RD2 = (WA == IR_In[20:16] & WA != 0 & RegWrite) ? RegData : Reg[RA2];
	 
	 integer i = 0;
	 reg [31:0] Reg [31:0];

    initial begin
	    for(i = 0; i < 32; i = i + 1)
		    Reg[i] = 32'h00000000;
	 end
	 
	 always @ (posedge clk) begin
	    
		 if (reset) begin
		    for(i = 0; i < 32; i = i + 1)
		       Reg[i] <= 32'h00000000;
	    end
		 
		 else begin
		    if (RegWrite & WA != 0) begin
			    $display("%d@%h: $%d <= %h", $time, PC_Out, WA, RegData);
             if (WA != 0) begin
                Reg[WA] <= RegData;
             end
          end
		 end
		 
	 end

endmodule
