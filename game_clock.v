`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:21:44 04/16/2016 
// Design Name: 
// Module Name:    game_clock 
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
module game_clock(
	 input clk,
	 output gclk
    );
	 reg[17:0] counter;
	 
	 always @(posedge clk)
	 begin
		counter <= counter + 1;
	 end
	 
	 assign gclk = &counter;

endmodule
