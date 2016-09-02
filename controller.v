`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Hard Mode Super PONG
// Engineer: Kenneth L. Rader
// 
// Create Date:    15:03:40 04/13/2016 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input P1Left,
    input P1Right,
    input clk,
     //input reset,
     output reg [1:0] paddle);
 
//	 wire c_P1Left;
//	 wire c_P1Right;
//	 wire c_P2Left;
//	 wire c_P2Right;
//	 
//	 debounce LEFT1(
//		//.reset(reset), 
//		.clk(clk), 
//		.noisy(P1Left), 
//		.clean(c_P1Left)
//		);
//		
//	debounce LEFT2(
//		//.reset(reset), 
//		.clk(clk), 
//		.noisy(P2Left), 
//		.clean(c_P2Left)
//		);
//		
//	debounce RIGHT1(
//		//.reset(reset), 
//		.clk(clk), 
//		.noisy(P1Right), 
//		.clean(c_P1Right)
//		);
//		
//	debounce RIGHT2(
//		//.reset(reset), 
//		.clk(clk), 
//		.noisy(P2Right), 
//		.clean(c_P2Right)
//		);

reg d = 0;

always @(posedge clk)
begin
    if(d) begin
        d <= 0;
        if ((P1Left == 1) & (P1Right == 0)) begin paddle <= 2'b01; end
        else if ((P1Left == 0) & (P1Right == 1)) begin paddle <= 2'b10; end
		  else paddle <= 2'b00;
        end
        else begin
            paddle <= 2'b00;
            d <= 1;
        end

    end

    endmodule
