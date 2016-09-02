`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:56:20 04/08/2016 
// Design Name: 
// Module Name:    display_clock 
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
module display_clock(
	input wire clk,		// main clock: 50MHz
	output wire dclk		// pixel clock: 25MHz
   );
	//counter
	reg [1:0] c;
	always @(posedge clk)
	begin
		c <= c+ 1;
	end
	
	// 50Mhz ÷ 2^1 = 25MHz
	assign dclk = ^c;

endmodule
