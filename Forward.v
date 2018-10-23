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
// Create Date:    23:19:06 07/16/2018 
// Design Name: 
// Module Name:    Forward 
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
module Forward(
    input [31:0] IR_D,
	 input [31:0] IR_E,
	 input [31:0] IR_M,
	 input [31:0] IR_W,
	 output [1:0] ForwardRSD,
	 output [1:0] ForwardRTD,
	 output [1:0] ForwardRSE,
	 output [1:0] ForwardRTE,
	 output [1:0] ForwardRTM
    );
	 
	 wire [2:0] D_type;
	 wire [2:0] E_type;
	 wire [2:0] M_type;
	 wire [2:0] W_type;
	 
	 Type D_Type(IR_D, D_type);
	 Type E_Type(IR_E, E_type);
	 Type M_Type(IR_M, M_type);
	 Type W_Type(IR_W, W_type);
	 
	 reg [1:0] RSD;
	 reg [1:0] RTD;
	 reg [1:0] RSE;
	 reg [1:0] RTE;
	 reg [1:0] RTM;
	 
	 reg [2:0] test;
	 
	 assign ForwardRSD = RSD;
	 assign ForwardRTD = RTD;
	 assign ForwardRSE = RSE;
	 assign ForwardRTE = RTE;
	 assign ForwardRTM = RTM;
	 
	 initial begin
	    RSD <= 2'b00;
		 RTD <= 2'b00;
		 RSE <= 2'b00;
		 RTE <= 2'b00;
		 RTM <= 2'b00;
	 end
	  
	 always @ (*) begin
	    
		 //RSD
		 if (D_type == 3'b011 | D_type == 3'b110) begin //Beq | Jr
		    
			 if (M_type == 3'b001 & IR_D[`rs] != 0 & IR_D[`rs] == IR_M[`rd])//Cal_R
				 RSD <= 2'b01;
	
			 else if (M_type == 3'b010 & IR_D[`rs] != 0 & IR_D[`rs] == IR_M[`rt])//Cal_I
				 RSD <= 2'b01;
							 
			 else if (M_type == 3'b111 & IR_D[`rs] != 0 & IR_D[`rs] == 5'b11111)//Jal
				 RSD <= 2'b10;

			 else
				 RSD <= 2'b00;

		 end
		
		 else 
		    RSD <= 2'b00;
			 
		 //RTD
		 if (D_type == 3'b011) begin //Beq
		    
			 if (M_type == 3'b001 & IR_D[`rt] != 0 & IR_D[`rt] == IR_M[`rd])//Cal_R
			    RTD <= 2'b01;
			 
			 else if (M_type == 3'b010 & IR_D[`rt] != 0 & IR_D[`rt] == IR_M[`rt])//Cal_I
			    RTD <= 2'b01;
			 
			 else if (M_type == 3'b111 & IR_D[`rt] != 0 & IR_D[`rt] == 5'b11111)//Jal
			    RTD <= 2'b10;
		    
			 else
			    RTD <= 2'b00;
		 
		 end
		 
		 else
		    RTD <= 2'b00;
		
       //RSE
		  if (E_type == 3'b001 | E_type == 3'b010 | E_type == 3'b100 | E_type == 3'b101) begin//Cal_R | Cal_I | Load | Save
		     
			  if (M_type == 3'b001 & IR_E[`rs] != 0 & IR_E[`rs] == IR_M[`rd])//Cal_R
			     RSE <= 2'b01;
			  
			  else if (M_type == 3'b010 & IR_E[`rs] != 0 & IR_E[`rs] == IR_M[`rt])//Cal_I
			     RSE <= 2'b01;
				  
			  else if (W_type == 3'b001 & IR_E[`rs] != 0 & IR_E[`rs] == IR_W[`rd])//Cal_R
			     RSE <= 2'b10;
			  
			  else if (W_type == 3'b010 & IR_E[`rs] != 0 & IR_E[`rs] == IR_W[`rt])//Cal_I
			     RSE <= 2'b10;
			  
			  else if (W_type == 3'b111 & IR_E[`rs] != 0 & IR_E[`rs] == 5'b11111)//Jal
			     RSE <= 2'b10;
			  
			  else if (W_type == 3'b100 & IR_E[`rs] != 0 & IR_E[`rs] == IR_W[`rt])//Load
			     RSE <= 2'b10;
			  
			  else if (M_type == 3'b111 & IR_E[`rs] != 0 & IR_E[`rs] == 5'b11111)//Jal
			     RSE <= 2'b11;
			  
			  else
		        RSE <= 2'b00;
				 
		  end
		  
		  else
		     RSE <= 2'b00;
			  
		 //RTE
		 if (E_type == 3'b001 | E_type == 3'b101) begin//Cal_R | Save
		    			 
          if (M_type == 3'b001 & IR_E[`rt] != 0 & IR_E[`rt] == IR_M[`rd])//Cal_R
			    RTE <= 2'b10;
			 
			 else if (M_type == 3'b010 & IR_E[`rt] != 0 & IR_E[`rt] == IR_M[`rt])//Cal_I
			    RTE <= 2'b10;
			 
			 else if (M_type == 3'b111 & IR_E[`rt] != 0 & IR_E[`rt] == 5'b11111)//Jal
			     RTE <= 2'b11;
			 
			 else if (W_type == 3'b001 & IR_E[`rt] != 0 & IR_E[`rt] == IR_W[`rd])//Cal_R
			     RTE <= 2'b01;
				 
			 else if (W_type == 3'b010 & IR_E[`rt] != 0 & IR_E[`rt] == IR_W[`rt])//Cal_I 
			     RTE <= 2'b01;

			 else if (W_type == 3'b111 & IR_E[`rt] != 0 & IR_E[`rt] == 5'b11111)//Jal
			     RTE <= 2'b01;
				 
			 else if (W_type == 3'b100 & IR_E[`rt] != 0 & IR_E[`rt] == IR_W[`rt])//Load
			     RTE <= 2'b01;
				  
			 else
			    RTE <= 2'b00;
			 
		 end
		 
		 else
		    RTE <= 2'b00;
			 		  
		  //RTM
		 if (M_type == 3'b101) begin//Save
          
			 if (W_type == 3'b001 & IR_M[`rt] != 0 & IR_M[`rt] == IR_W[`rd])//Cal_R
			    RTM <= 2'b01;
			 
			 else if (W_type == 3'b010 & IR_M[`rt] != 0 & IR_M[`rt] == IR_W[`rt])//Cal_I
			    RTM <= 2'b01;
				 
			 else if (W_type == 3'b100 & IR_M[`rt] != 0 & IR_M[`rt] == IR_W[`rt])//Load
			    RTM <= 2'b01;
			 
			 else if (W_type == 3'b111 & IR_M[`rt] != 0 & IR_M[`rt] == 5'b11111)//Jal
			    RTM <= 2'b01;
				 
			 else
			    RTM <= 2'b00;
				 
		 end
		 
		 else
		    RTM <= 2'b00;
		    
	 end
	 

endmodule

module Type(
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
	 