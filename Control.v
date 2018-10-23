`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:27:10 07/15/2018 
// Design Name: 
// Module Name:    Control 
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
module Control(
    input [31:0] IR_In, //IF_ID_IR_Out
    output reg RegWrite,
    output reg MemToReg,
    output reg MemWrite,
    output reg [2:0] ALUOp,
    output reg ALUSrcA,
	 output reg ALUSrcB,
    output reg RegDst,
    output reg Branch,
	 output reg [1:0] Jump,
	 output reg [2:0] EXTOp
    );
	 
	 wire [5:0] Op;
	 wire [5:0] Func;
	 
	 assign Op = IR_In[31:26];
	 assign Func = IR_In[5:0];
	 
	 initial begin
	    RegWrite <= 0;
		 MemToReg <= 0;
		 MemWrite <= 0;
		 ALUOp <= 3'b000;
		 ALUSrcA <= 0;
		 ALUSrcB <= 0;
		 RegDst <= 0;
		 Branch <= 0;
		 Jump <= 2'b00;
		 EXTOp <= 3'b000;
	 end
	 
	 always @ (*) begin
	    
		 if(Op == 6'b000000) begin
		 
		    if(Func == 6'b100001) begin //Addu
			    RegWrite <= 1;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b000;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 1;
		       Branch <= 0;
				 Jump <= 2'b00;
				 EXTOp <= 3'b000;
			 end
			 
			 if(Func == 6'b100011) begin //Subu
			    RegWrite <= 1;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b001;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 1;
		       Branch <= 0;
				 Jump <= 2'b00;
				 EXTOp <= 3'b000;
			 end
			 
			 if(Func == 6'b001000) begin //Jr
			    RegWrite <= 0;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b100;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 0;
		       Branch <= 1;
				 Jump <= 2'b10;
				 EXTOp <= 3'b000;
			 end
			 
			 if(Func == 6'b000000) begin //Nop
			    RegWrite <= 0;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b000;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 0;
		       Branch <= 0;
				 Jump <= 2'b00;
				 EXTOp <= 3'b000;
			 end
			 
		 end
		 
		 else begin
		    
			 if(Op == 6'b001101) begin //Ori
			    RegWrite <= 1;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b010;
		       ALUSrcA <= 0;
		       ALUSrcB <= 1;
		       RegDst <= 0;
		       Branch <= 0;
				 Jump <= 2'b00;
				 EXTOp <= 3'b000;
			 end
			 
			 if(Op == 6'b100011) begin //Lw
			    RegWrite <= 1;
		       MemToReg <= 1;
		       MemWrite <= 0;
		       ALUOp <= 3'b000;
		       ALUSrcA <= 0;
		       ALUSrcB <= 1;
		       RegDst <= 0;
		       Branch <= 0;
				 Jump <= 2'b00;
				 EXTOp <= 3'b011;
			 end
			 
			 if(Op == 6'b101011) begin //Sw
			    RegWrite <= 0;
		       MemToReg <= 0;
		       MemWrite <= 1;
		       ALUOp <= 3'b000;
		       ALUSrcA <= 0;
		       ALUSrcB <= 1;
		       RegDst <= 0;
		       Branch <= 0;
				 Jump <= 2'b00;
				 EXTOp <= 3'b011;
			 end
			 
			 if(Op == 6'b000100) begin //Beq
			    RegWrite <= 0;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b000;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 0;
		       Branch <= 1;
				 Jump <= 2'b00;
				 EXTOp <= 3'b010;
			 end
			 
			 if(Op == 6'b001111) begin //Lui
			    RegWrite <= 1;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b011;
		       ALUSrcA <= 0;
		       ALUSrcB <= 1;
		       RegDst <= 0;
		       Branch <= 0;
				 Jump <= 2'b00;
				 EXTOp <= 3'b001;
			 end
			 
			 if(Op == 6'b000010) begin //J
			    RegWrite <= 0;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b000;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 0;
		       Branch <= 1;
				 Jump <= 2'b01;
				 EXTOp <= 3'b100;
			 end
			 
			 if(Op == 6'b000011) begin //Jal
			    RegWrite <= 1;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b000;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 0;
		       Branch <= 1;
				 Jump <= 2'b01;
				 EXTOp <= 3'b100;
			 end
			 
			 if(Op == 6'b111111) begin //Bgezalr 
			    RegWrite <= 1;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b000;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 1;
		       Branch <= 1;
				 Jump <= 2'b11;
				 EXTOp <= 3'b000;
			 end
			 
			 if(Op == 6'b011111) begin //Seb
			    RegWrite <= 1;
		       MemToReg <= 0;
		       MemWrite <= 0;
		       ALUOp <= 3'b101;
		       ALUSrcA <= 0;
		       ALUSrcB <= 0;
		       RegDst <= 1;
		       Branch <= 0;
				 Jump <= 2'b00;
				 EXTOp <= 3'b000;
			 end

       end
    
	 end
	 
endmodule
