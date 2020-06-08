module tb ();
  logic clk;
  logic [3:0] a,b,y,y_expected;
  logic [3:0] ALUcontrol;
  logic [5:0] flag, flag_expected;
  
  logic [33:0] vectorNum, error;
  logic [1000:0] testVector[23:0];
  
  ALU dut(a, b, ALUcontrol, y, flag);
  
  always
  begin
  clk = 1; #50; clk=0; #50;
  end
  
  initial
  begin
  $readmemh("testcase.tv", testVector);
  vectorNum = 0; error = 0;
  end
  always @(posedge clk)
   begin
			#1;
			ALUcontrol = testVector[vectorNum][23:20];
			a = testVector[vectorNum][19:16];
			b = testVector[vectorNum][15:12];
			y_expected = testVector[vectorNum][11:8];
			flag_expected = testVector[vectorNum][5:0];
		end
  always @(negedge clk)
     begin
	  if (y!== y_expected || flag!==flag_expected)
	  begin
	  $display("Error in vector %d", vectorNum);
	  $display("Inputs : a = %b, b = %b, ALUcontrol = %b", a, b, ALUcontrol);
	  $display("Outputs : y = %b (%b expected), flag = %b(%b expected)",
	  y, y_expected, flag, flag_expected);
	  error = error+1;
	  end
	  vectorNum = vectorNum + 1;
	  if (testVector[vectorNum][0] === 1'bx)
	   begin
	     $display("%d tests completed with %d error(s)", vectorNum, error);
		  $stop;
      end
    end
		  
endmodule
	  

