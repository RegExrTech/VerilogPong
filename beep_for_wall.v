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

module beep_for_wall(
  input clk, e, game_end,
  output reg speaker
  );

  reg turnOnBeep = 0;
  reg [22:0] c;
  reg dclk = 0;
  
  wire enable = e & ~game_end;
  

  
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
      if(count==56818/2)
        count<=0;
      else
        count <= count+1;
		end
    end


  always @(posedge clk, posedge enable)
    begin
	 if (enable) 
	 begin
		turnOnBeep <= 1;
		dclk <= 0;
	 end
	 else 
		 if(game_end) begin
			speaker <= 0;
			turnOnBeep <= 0; end
		 else begin
		 if(turnOnBeep)
			begin
			if (&c == 1)
				begin
					speaker <= 0;
					turnOnBeep <= 0;
				end
			else
			begin
				dclk <= &c;
				if(count==56818/2)
					speaker <= ~speaker;
				else
					speaker <= speaker;
			end
			end
		end
    end
endmodule



