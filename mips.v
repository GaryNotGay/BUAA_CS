`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:08 07/16/2018 
// Design Name: 
// Module Name:    mips 
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
`define op 31:26
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define func 5:0
`define imm16 15:0
`define imm26 25:0

module mips(
    input clk,
    input reset
    );
	 
	 ////////////////////IF
	 
	 //F_PC
	 wire [31:0] PC_Next;
    wire [31:0] PC_Out;
	 wire PC_En;
	 
	 //F_NPC    
	 wire Zero;
	 
	 //F_IM
	 wire [31:0] IR;
	 	 
	 ////////////////////IF_ID
	 wire IF_ID_En;
	 wire [31:0] IR_D;
	 wire [31:0] PC_D;
	 
	 ////////////////////ID
	 
	 //D_Control
    wire Branch;
	 wire [1:0] Jump;
	 wire [2:0] EXTOp;
	 
	 //D_GRF
	 wire [4:0] RegDataWriteAddr;
	 wire [31:0] RegDataIn;
	 wire [31:0] RegDataOut1;
	 wire [31:0] RegDataOut2;
	 
    //D_EXT
	 wire [31:0] EXT_Out;
	 
	 //D_CMP
	 wire Bgezalr;
	 
	 //D_WAMUX
	 
	 ////////////////////ID_EX
	 wire ID_EX_Clr;
	 wire [31:0] IR_E;
	 wire [31:0] PC_E;
	 wire [31:0] RegDataOut1_D_In;
	 wire [31:0] RegDataOut2_D_In;
 	 wire [31:0] RegDataOut1_E;
	 wire [31:0] RegDataOut2_E;
	 wire [31:0] EXT_Out_E;
	 
	 ////////////////////EX
	 
	 //E_Control
	 wire [2:0] ALUOp;
	 wire ALUSrcA;
	 wire ALUSrcB;
	 
	 //E_ALU
	 wire [31:0] ALU_In_A;
	 wire [31:0] ALU_In_B;
	 wire [31:0] ALU_Out;
	 
	 //E_ALUSrcA
	 
	 //E_ALUSrcB
	 
	 //E_WA_MUX
	 
	 ////////////////////EX_MEM
	 wire [31:0] RegDataOut2_E_In;
	 wire [31:0] RegDataOut1_E_In;
	 wire [31:0] IR_M;
	 wire [31:0] RegDataOut2_M;
	 wire [31:0] PC_M;
	 wire [31:0] ALU_Out_M;
	 
	 ////////////////////MEM
	 
	 //M_Control
	 wire MemWrite;
	 
	 //M_DM
	 wire [31:0] WriteData;
	 wire [31:0] DM_Out;
	 
	 ////////////////////MEM_WB
	 wire [31:0] IR_W;
	 wire [31:0] PC_W;
	 wire [31:0] ALU_Out_W;
	 wire [31:0] DM_Out_W;
	 
	 ////////////////////WB
	 
	 //W_Control
	 wire MemToReg;
	 wire RegWrite;
	 wire RegDst;
	 
	 ////////////////////Forward
	 wire [1:0] ForwardRSD;
	 wire [1:0] ForwardRTD;
	 wire [1:0] ForwardRSE;
	 wire [1:0] ForwardRTE;
	 wire [1:0] ForwardRTM;
	 	 
	 ////////////////////////////////////////////////////////////////////////////////
	 
	 ////////////////////IF
	 
	 //F_PC
	 PC F_PC(
	    .clk(clk),
		 .reset(reset),
		 .PC_En(PC_En),
		 .PC_Next(PC_Next),
		 .PC_Out(PC_Out));
		 
	 //F_NPC
	 NPC F_NPC(
	    .Branch(Branch),
		 .Zero(Zero),
		 .Bgezalr(Bgezalr),
		 .Jump(Jump),
		 .EXT_Out(EXT_Out),
		 .PC_Out(PC_Out),
		 .PC_D(PC_D),
		 .PC_Next(PC_Next),
		 .RD1(RegDataOut1_D_In),
		 .RD2(RegDataOut2_D_In));
	 	 
	 //F_IM	 
	 IM F_IM(
	    .PC_Out(PC_Out),
		 .IM_Out(IR));
		 
	 ////////////////////IF_ID
	 IF_ID IF_ID(
	    .clk(clk),
		 .reset(reset),
		 .IF_ID_En(IF_ID_En),
		 .IR_In(IR),
		 .IR_Out(IR_D),
		 .PC_Out_In(PC_Out),
		 .PC_Out_Out(PC_D));
	 
	 ////////////////////ID
		 
	 //D_Control
	 Control D_Control(
	    .IR_In(IR_D),
		 .Branch(Branch),
		 .EXTOp(EXTOp),
		 .Jump(Jump));
		 
	 //D_GRF
	 GRF D_GRF(
	    .clk(clk),
		 .reset(reset),
		 .RegWrite(RegWrite),
		 .WA(RegDataWriteAddr),
		 .RegData(RegDataIn),
		 .PC_Out(PC_W),
		 .IR_In(IR_D),
		 .RD1(RegDataOut1),
		 .RD2(RegDataOut2));
		 		 
	 //D_EXT
	 EXT D_EXT(
	    .IR_In(IR_D),
		 .RD2(RegDataOut2_D_In),
		 .EXTOp(EXTOp),
		 .EXT_Out(EXT_Out));
	 
	 //D_CMP
	 CMP D_CMP(
	    .RD1(RegDataOut1_D_In),
		 .RD2(RegDataOut2_D_In),
		 .Bgezalr(Bgezalr),
		 .Zero(Zero));
		 
	 //D_MFRTD
	 MFRTD D_MFRTD(
	     .ForwardRTD(ForwardRTD),
		  .RD2(RegDataOut2),
		  .ALU_Out_M(ALU_Out_M),
		  .PC_Out_M(PC_M),
		  .RT_D(RegDataOut2_D_In));
	 
	 //D_MFRSD	  
	 MFRSD D_MFRSD(
	     .ForwardRSD(ForwardRSD),
		  .RD1(RegDataOut1),
		  .ALU_Out_M(ALU_Out_M),
		  .PC_Out_M(PC_M),
		  .RS_D(RegDataOut1_D_In));
		 	 
	 ////////////////////ID_EX
    ID_EX ID_EX(
       .clk(clk),
       .reset(reset),
       .ID_EX_Clr(ID_EX_Clr),
		 .IR_In(IR_D),
		 .IR_Out(IR_E),
		 .PC_Out_In(PC_D),
		 .PC_Out_Out(PC_E),
		 .RD1_In(RegDataOut1_D_In),
		 .RD1_Out(RegDataOut1_E),
		 .RD2_In(RegDataOut2_D_In),
		 .RD2_Out(RegDataOut2_E),
		 .EXT_In(EXT_Out),
		 .EXT_Out(EXT_Out_E));
	
	  ////////////////////EX
	  
	  //E_Control
	  Control E_Control(
	     .IR_In(IR_E),
		  .ALUOp(ALUOp),
		  .ALUSrcA(ALUSrcA),
		  .ALUSrcB(ALUSrcB));
		  
	  //E_ALU
	  ALU E_ALU(
	     .A(ALU_In_A),
		  .B(ALU_In_B),
		  .ALUOp(ALUOp),
		  .ALU_Out(ALU_Out));
		  
	  //E_ALUSrcA
	  ALU_MUX_A E_ALUSrcA(
	     .ALUSrcA(ALUSrcA),
		  .RD1(RegDataOut1_E_In),
		  .ALU_A(ALU_In_A));
	  
	  //E_ALUSrcB
	  ALU_MUX_B E_ALUSrcB(
	     .ALUSrcB(ALUSrcB),
		  .EXT_Out(EXT_Out_E),
		  .RD2(RegDataOut2_E_In),
		  .ALU_B(ALU_In_B));
		  
	  //E_MFRTE
	  MFRTE E_MFRTE(
	     .ForwardRTE(ForwardRTE),
		  .RD2(RegDataOut2_E),
		  .ALU_Out_M(ALU_Out_M),
		  .PC_Out_M(PC_M),
		  .RegData(RegDataIn),
		  .RT_E(RegDataOut2_E_In));
		  
	  //E_MFRSE
	  MFRSE E_MFRSE(
	     .ForwardRSE(ForwardRSE),
		  .RD1(RegDataOut1_E),
		  .ALU_Out(ALU_Out_M),
		  .RegData(RegDataIn),
		  .PC_Out_M(PC_M),
		  .RS_E(RegDataOut1_E_In));
		
	  ////////////////////EX_MEM
	  EX_MEM EX_MEM(
	     .clk(clk),
		  .reset(reset),
		  .EX_MEM_En(EX_MEM_En),
		  .IR_In(IR_E),
		  .IR_Out(IR_M),
		  .RD2_In(RegDataOut2_E_In),
		  .RD2_Out(RegDataOut2_M),
		  .PC_Out_In(PC_E),
		  .PC_Out_Out(PC_M),
		  .ALU_Out_In(ALU_Out),
		  .ALU_Out_Out(ALU_Out_M));
	 
	  ////////////////////MEM  
	  
	  //M_Control
	  Control M_Control(
	     .IR_In(IR_M),
		  .MemWrite(MemWrite));
		  
	  //M_MFRTM
	  MFRTM M_MFRTM(
	     .ForwardRTM(ForwardRTM),
		  .RD2_M(RegDataOut2_M),
		  .RD2_W(RegDataIn),
		  .WriteData(WriteData));
	 
	  //M_DM
	  DM M_DM(
	     .clk(clk),
		  .reset(reset),
		  .IR_In(IR_M),
		  .MemWrite(MemWrite),
		  .PC_Out(PC_M),
		  .ALU_Out(ALU_Out_M),
		  .WD(WriteData),
		  .DM_Out(DM_Out));
		  
	  ////////////////////MEM_WB
     MEM_WB MEM_WB(
        .clk(clk),
		  .reset(reset),
        .MEM_WB_En(MEM_WB_En),
		  .IR_In(IR_M),
		  .IR_Out(IR_W),
		  .ALU_Out_In(ALU_Out_M),
		  .ALU_Out_Out(ALU_Out_W),
		  .DM_Out_In(DM_Out),
		  .DM_Out_Out(DM_Out_W),
		  .PC_Out_In(PC_M),
		  .PC_Out_Out(PC_W));
		  
	  ////////////////////WB
	  
	  //W_Control
	  Control W_Control(
	     .IR_In(IR_W),
		  .RegDst(RegDst),
		  .MemToReg(MemToReg),
		  .RegWrite(RegWrite));
	  
	  //W_RegDataMUX
	  RegData_MUX W_RegDataMUX(
	     .MemToReg(MemToReg),
		  .ALU_Out(ALU_Out_W),
		  .DM_Out(DM_Out_W),
		  .PC(PC_W),
		  .IR(IR_W),
		  .RegData(RegDataIn));
		  
	  //W_WA_MUX
	  WA_MUX W_WA_MUX(
	     .IR_In(IR_W),
		  .RegDst(RegDst),
		  .WA(RegDataWriteAddr));
		  
	  ////////////////////Forward
	  Forward Forward(
        .IR_D(IR_D),
        .IR_E(IR_E),
        .IR_M(IR_M),
        .IR_W(IR_W),
        .ForwardRSD(ForwardRSD),
        .ForwardRSE(ForwardRSE),
        .ForwardRTD(ForwardRTD),
        .ForwardRTE(ForwardRTE),
        .ForwardRTM(ForwardRTM));
		  
	  ////////////////////Stall
	  Stall Stall(
	     .IR_D(IR_D),
        .IR_E(IR_E),
        .IR_M(IR_M),
        .PC_En(PC_En),
		  .IF_ID_En(IF_ID_En),
		  .ID_EXE_Clr(ID_EX_Clr));
	 
endmodule
