module ALU (input logic [3:0] a,b, input logic [3:0] ALUControl, output logic [3:0] result, output logic [5:0] flag);

    logic neg, zero, carry, overflow, equal, lessThan;
	 logic [3:0] Inv;
	 logic [4:0] sum;
	 assign Inv = ALUControl[0] ? ~b:b;
	 assign sum = a + Inv + ALUControl[0];
	 
	 always@*
		 casex(ALUControl[3:0])
			 4'b000?: result = sum[3:0];           //addition-subtraction 
			 4'b0010: result = a*b;                //multiply
			 4'b0011: result = a/b;                //devision
			 4'b0100: result = a<<1 ;              //logical shift left
			 4'b0101: result = a>>1 ;              //logical shift right
			 4'b0110: result = a>>>1 ;             //mathematical shift right
			 4'b0111: result = {a[0], a[3:1]};     //rotate right
			 4'b1000: result = a&b;                //and
			 4'b1001: result = a|b;                //or
			 4'b1010: result = a ^ b;              //xor
			 4'b1011: result = ~a ;                //invert
			 default: result = 4'b0000;
	    endcase
		 
	assign neg      =  result[3];
	assign zero     = (result == 4'b0);
	assign carry    = (ALUControl[3:1] == 3'b000) & sum[4];
	assign overflow = (ALUControl[3:1] == 3'b000) & ~(a[3] ^ b[3] ^ ALUControl[0]) & (a[3]^sum[3]);
	assign equal    = (a == b);
	assign lessThan = (a < b);
  
  assign flag = {neg , zero, carry, overflow, equal, lessThan};
  endmodule

