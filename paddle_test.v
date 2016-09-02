`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:03 04/16/2016 
// Design Name: 
// Module Name:    paddle_test 
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
module paddle_test(
		input clk,
		output reg[1:0] tclock1,
		output reg[1:0] tclock2
    );
	 
	 always @(clk)
	 begin
		tclock1[1] <= 0;
		tclock2[1] <= 0;
		tclock1[0] <= clk;
		tclock2[0] <= clk;
	 end
	 
	//assign tclock1[0] = 0;
	 //assign tclock1[1] = &counter;
	//assign tclock2[0] = 0;
	 //assign tclock2[1] = &counter;
endmodule
