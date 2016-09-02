`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Devon Wasson
//
// Create Date:    04/11/2016
// Design Name:
// Module Name:    beep
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments: In an effort to not have to reinvent the wheel, sections of this code
//                      have been copied from http://www.fpga4fun.com/MusicBox1.html
//
//////////////////////////////////////////////////////////////////////////////////

module beep(
  input clk, e,
  output reg speaker
  );

  reg e;
  reg turnOnBeep = 0;
  reg [22:0] c;
  reg dclk = 0;
  


  always @(posedge clk)
	begin
	  if(turnOnBeep)
	   begin
		if (dclk == 1)
			dclk <= dclk;
		else	
			dclk <= &c;
		end
	end
  
  always @(posedge clk)
    begin
	  if(turnOnBeep)
	   begin
		if (dclk==1)
				c <= c;
			else
				c <= c+ 1;
		end
	 end
	



  reg [16:0] count;
  always @(posedge clk)
    begin
	  if(turnOnBeep)
	   begin
      if(count==56818)
        count<=0;
      else
        count <= count+1;
		end
    end


  always @(posedge clk, posedge e)
    begin
	 if (e) turnOnBeep <= 1;
	  else if(turnOnBeep)
	   begin
      if (dclk == 1)
			begin
				speaker <= 0;
				turnOnBeep <= 0;
			end
		else
			if(count==56818)
				speaker <= ~speaker;
			else
				speaker <= speaker;
		end
    end
endmodule



