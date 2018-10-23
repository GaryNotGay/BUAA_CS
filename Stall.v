`timescale 1ns / 1ps

`define op 31:26
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define func 5:0
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:18:45 07/16/2018 
// Design Name: 
// Module Name:    Stall 
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
module Stall(
    input [31:0] IR_D,
	 input [31:0] IR_E,
	 input [31:0] IR_M,
	 output PC_En,
    output IF_ID_En,
    output ID_EXE_Clr	 
    );
    
	 wire [2:0] D_type;
	 wire [2:0] E_type;
	 wire [2:0] M_type;

    Type_S D_Type_S(IR_D, D_type);
	 Type_S E_Type_S(IR_E, E_type);
	 Type_S M_Type_S(IR_M, M_type);
	 
	 reg stall_Beq_rs;
	 reg stall_Beq_rt;
	 reg stall_Cal_R_rs;
	 reg stall_Cal_R_rt;
	 reg stall_Cal_I_rs;
	 reg stall_Load_rs;
	 reg stall_Save_rs;
	 reg stall_Jr_rs;
	 
	 wire Stall_Beq_rs;
	 wire Stall_Beq_rt;
	 wire Stall_Cal_R_rs;
	 wire Stall_Cal_R_rt;
	 wire Stall_Cal_I_rs;
	 wire Stall_Load_rs;
	 wire Stall_Save_rs;
	 wire Stall_Jr_rs;
	 
	 initial begin
	    stall_Beq_rs <= 0;
	    stall_Beq_rt <= 0;
	    stall_Cal_R_rs <= 0;
	    stall_Cal_R_rt <= 0;
	    stall_Cal_I_rs <= 0;
	    stall_Load_rs <= 0;
	    stall_Save_rs <= 0;
	    stall_Jr_rs <= 0;
	 end
	 
	 always @ (*) begin
	    
		 //stall_Beq_rs
		 if (D_type == 3'b011) begin//Beq
		    
			 if (E_type == 3'b001 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rd])//Cal_R
		       stall_Beq_rs <= 1;
			 
			 else if (E_type == 3'b010 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rt])//Cal_I
			    stall_Beq_rs <= 1;
				 
			 else if (E_type == 3'b100 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rt])//Load
			    stall_Beq_rs <= 1;
				 
			 else if (M_type == 3'b100 & IR_D[`rs] != 0 & IR_D[`rs] == IR_M[`rt])//Load
			    stall_Beq_rs <= 1;	 
				 
			 else if (E_type == 3'b111 & IR_D[`rs] != 0 & IR_D[`rs] == 5'b11111)//Jal
			    stall_Beq_rs <= 1;
				 
			 else
			    stall_Beq_rs <= 0;
		
		 end
		 
		 else
          stall_Beq_rs <= 0;	

       //stall_Beq_rt			 
		 if (D_type == 3'b011) begin//Beq
		    
			 if (E_type == 3'b001 & IR_D[`rt] != 0 & IR_D[`rt] == IR_E[`rd])//Cal_R
		       stall_Beq_rt <= 1;
			 
			 else if (E_type == 3'b010 & IR_D[`rt] != 0 & IR_D[`rt] == IR_E[`rt])//Cal_I
			    stall_Beq_rt <= 1;
				 
			 else if (E_type == 3'b100 & IR_D[`rt] != 0 & IR_D[`rt] == IR_E[`rt])//Load
			    stall_Beq_rt <= 1;
				 
			 else if (M_type == 3'b100 & IR_D[`rt] != 0 & IR_D[`rt] == IR_M[`rt])//Load
			    stall_Beq_rt <= 1;	 
				 
			 else if (E_type == 3'b111 & IR_D[`rt] != 0 & IR_D[`rt] == 5'b11111)//Jal
			    stall_Beq_rt <= 1;
				 
			 else
			    stall_Beq_rt <= 0;
		
		 end
		 
		 else
          stall_Beq_rt <= 0;
			 
		 //stall_Cal_R_rs
		 if (D_type == 3'b001 & E_type == 3'b100 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rt])//Cal_R Load
		    stall_Cal_R_rs <= 1;
		 else
		    stall_Cal_R_rs <= 0;
		
		 //stall_Cal_R_rt
		 if (D_type == 3'b001 & E_type == 3'b100 & IR_D[`rt] != 0 & IR_D[`rt] == IR_E[`rt])//Cal_R Load
		    stall_Cal_R_rt <= 1;
		 else
		    stall_Cal_R_rt <= 0;
		 
		 //stall_Cal_I_rs
		 if (D_type == 3'b010 & E_type == 3'b100 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rt])//Cal_I Load
		    stall_Cal_I_rs <= 1;
		 else
		    stall_Cal_I_rs <= 0;
			 
		 //stall_Load_rs
		 if (D_type == 3'b100 & E_type == 3'b100 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rt])//Load Load
		    stall_Load_rs <= 1;
		 else
		    stall_Load_rs <= 0;
		 
		 //stall_Save_rs
		 if (D_type == 3'b101 & E_type == 3'b100 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rt])//Save Load
		    stall_Save_rs <= 1;
		 else
		    stall_Save_rs <= 0;
		 
		 //stall_Jr_rs
		 if (D_type == 3'b110) begin//Jr
		    
			 if (E_type == 3'b001 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rd])//Cal_R
		       stall_Jr_rs <= 1;
			 
			 else if (E_type == 3'b010 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rt])//Cal_I
			    stall_Jr_rs <= 1;
				 
			 else if (E_type == 3'b100 & IR_D[`rs] != 0 & IR_D[`rs] == IR_E[`rt])//Load
			    stall_Jr_rs <= 1;
				 
			 else if (M_type == 3'b100 & IR_D[`rs] != 0 & IR_D[`rs] == IR_M[`rt])//Load
			    stall_Jr_rs <= 1;	 
				 
			 else if (E_type == 3'b111 & IR_D[`rs] != 0 & IR_D[`rs] == 5'b11111)//Jal
			    stall_Jr_rs <= 1;
				 
			 else
			    stall_Jr_rs <= 0;
		
		 end
		 
		 else
          stall_Jr_rs <= 0;	
			 
	 end
	 
	 wire stall;
	 assign stall = stall_Beq_rs | stall_Beq_rt | stall_Cal_R_rs | stall_Cal_R_rt | stall_Cal_I_rs | stall_Load_rs | stall_Save_rs | stall_Jr_rs;
	 
	 assign PC_En = !stall;
	 assign IF_ID_En = !stall;
	 assign ID_EXE_Clr = stall;
	 
endmodule

module Type_S(
    input [31:0] IR,
	 output [2:0] type
	 );
	 
	 reg [2:0] type_temp;
	 wire [5:0] Op;
	 wire [5:0] Func;
	 
	 assign type = type_temp;
	 assign Op = IR[31:26];
	 assign Func = IR[5:0];
	 
	 ////////////////////
	 //
	 //Nop 3'b000
	 //CAL_R 3'b001
	 //CAL_I 3'b010
	 //Beq 3'b011
	 //Load 3'b100
	 //Save 3'b101
	 //Jr 3'b110
	 //Jal 3'b111
	 //
	 ////////////////////
	 
	 always @ (*) begin
	    
		 if(Op == 6'b000000) begin
		 
		    if(Func == 6'b100001) begin //Addu--CAL_R
			    type_temp <= 3'b001;
			 end
			 
			 if(Func == 6'b100011) begin //Subu--CAL_R
			    type_temp <= 3'b001;
			 end
			 
			 if(Func == 6'b001000) begin //Jr--Jr
			    type_temp <= 3'b110;
			 end
			 
			 if(Func == 6'b000000) begin //Nop--Nop
			    type_temp <= 3'b000;
			 end
			 
		 end
		 
		 else begin
		    
			 if(Op == 6'b001101) begin //Ori--CAL_I
			    type_temp <= 3'b010;
			 end
			 
			 if(Op == 6'b100011) begin //Lw--Load
			    type_temp <= 3'b100;
			 end
			 
			 if(Op == 6'b101011) begin //Sw--Save
			    type_temp <= 3'b101;
			 end
			 
			 if(Op == 6'b000100) begin //Beq--Beq
			    type_temp <= 3'b011;
			 end
			 
			 if(Op == 6'b001111) begin //Lui--CAL_I
			    type_temp <= 3'b010;
			 end
			 
			 if(Op == 6'b000011) begin //Jal--Jal
			    type_temp <= 3'b111;
			 end
			 
			 if(Op == 6'b111111) begin //Bgezalr--Beq
			    type_temp <= 3'b011;
			 end
			 
			 if(Op == 6'b011111) begin //Seb--CAL_R
			    type_temp <= 3'b001;
			 end
 
       end
	 
	end
	
endmodule
	 
