`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:00:45 04/24/2016 
// Design Name: 
// Module Name:    game_reset 
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
module game_reset(
	input game_end,
	input other,
	input hard_reset,
	output reset
 );
 
 assign reset = (game_end && other) || (hard_reset);


endmodule
