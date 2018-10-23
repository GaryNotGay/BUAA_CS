`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:27:44 07/17/2018 
// Design Name: 
// Module Name:    MUX 
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
module ALU_MUX_A(
    input ALUSrcA,
    input [31:0] RD1,
    output [31:0] ALU_A
    ); 
	 
	 reg [31:0] A;
	 assign ALU_A = A;
	 
	 always @ (*) begin
	    
		 case (ALUSrcA) 
		 
		 0: A <= RD1;
		 
		 endcase
   
    end	

endmodule

module ALU_MUX_B(
    input ALUSrcB,
    input [31:0] RD2,
	 input [31:0] EXT_Out,
    output [31:0] ALU_B
    ); 
	 
	 reg [31:0] B;
	 assign ALU_B = B;
	 
	 always @ (*) begin
	    
		 case (ALUSrcB) 
		 
		 0: B <= RD2;
		 
		 1: B <= EXT_Out;
		 
		 endcase
   
    end	

endmodule

module RegData_MUX(
    input MemToReg,
	 input [31:0] ALU_Out,
	 input [31:0] DM_Out,
	 input [31:0] PC,
	 input [31:0] IR,
	 output [31:0] RegData
	 );
	 
	 reg [31:0] Data;
	 assign RegData = Data;
	 
	 always @ (*) begin
	 
	     if (MemToReg)
		     Data <= DM_Out;
		  else if ((IR[31:26] == 6'b000011) | (IR[31:26] == 6'b111111))
		     Data <= PC + 8;
		  else
		     Data <= ALU_Out;
	 
	 end

endmodule

module WA_MUX(
    input [31:0] IR_In,
    input RegDst,
    output [4:0] WA
    ); 
	 
	 reg [4:0] Addr;
	 assign WA = Addr;
	 
	 always @ (*) begin
	    
		 if (RegDst)
		    Addr <= IR_In[15:11];
		 else if (IR_In[31:26] == 6'b000011)
		    Addr <= 31;
		 else
		    Addr <= IR_In[20:16];
	 
	 end

endmodule

module MFRTM(
    input [1:0] ForwardRTM,
	 input [31:0] RD2_M,
	 input [31:0] RD2_W,
	 output [31:0] WriteData
	 );
	 
	 assign WriteData = (ForwardRTM == 2'b01) ? RD2_W : RD2_M;

endmodule

module MFRTE(
    input [1:0] ForwardRTE,
	 input [31:0] RD2,
	 input [31:0] RegData,
	 input [31:0] ALU_Out_M,
	 input [31:0] PC_Out_M,
	 output [31:0] RT_E
	 );
	 
	 reg [31:0] RT;
	 assign RT_E = RT;
	 
	 always @ (*) begin
	    
		 if (ForwardRTE == 2'b00)
		    RT <= RD2;
		 
		 if (ForwardRTE == 2'b01)
		    RT <= RegData;
			 
		 if (ForwardRTE == 2'b10)
		    RT <= ALU_Out_M;
			 
		 if (ForwardRTE == 2'b11)
		    RT <= PC_Out_M + 8;
	 
	 end
	 
endmodule 

module MFRSE(
    input [1:0] ForwardRSE,
	 input [31:0] RD1,
	 input [31:0] ALU_Out,
	 input [31:0] RegData,
	 input [31:0] PC_Out_M,
	 output [31:0] RS_E
	 );
	 
	 reg [31:0] RS;
	 assign RS_E = RS;
	 
	 always @ (*) begin
	    
		 if (ForwardRSE == 2'b00)
		    RS <= RD1;
		 
		 if (ForwardRSE == 2'b01)
		    RS <= ALU_Out;
		 
		 if (ForwardRSE == 2'b10)
		    RS <= RegData;
			 
		 if (ForwardRSE == 2'b11)
		    RS <= PC_Out_M + 8;
			 
	 end

endmodule
 
module MFRTD(
    input [1:0] ForwardRTD,
	 input [31:0] RD2,
	 input [31:0] ALU_Out_M,
	 input [31:0] PC_Out_M,
	 output [31:0] RT_D
	 );
	 
	 reg [31:0] RT;
	 assign RT_D = RT;
	 
	 always @ (*) begin
	    
		 if (ForwardRTD == 2'b00)
		    RT <= RD2;
			 
	    if (ForwardRTD == 2'b01)
		    RT <= ALU_Out_M;
		 
		 if (ForwardRTD == 2'b10)
		    RT <= PC_Out_M + 8;
	 
	 end
	 
endmodule 

module MFRSD(
    input [1:0] ForwardRSD,
	 input [31:0] RD1,
	 input [31:0] ALU_Out_M,
	 input [31:0] PC_Out_M,
	 output [31:0] RS_D
	 );
	 
	 reg [31:0] RS;
	 assign RS_D = RS;
	 
	 always @ (*) begin
	    
		 if (ForwardRSD == 2'b00)
		    RS <= RD1;
		 
		 if (ForwardRSD == 2'b01)
		    RS <= ALU_Out_M;
		 
		 if (ForwardRSD == 2'b10)
		    RS <= PC_Out_M + 8;
	 
	 end
	 
endmodule