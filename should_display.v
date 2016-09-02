`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Keyi Zhang
// 
// Create Date:    22:16:25 04/09/2016 
// Design Name: 
// Module Name:    should_display 
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
module should_display(
    input wire[9:0] paddle1_x1,	//x coordinate of paddle 1
    input wire[9:0] paddle1_x2,	//ycoordinate of paddle 1
    input wire[9:0] paddle2_x1,	//x_1 coordinate of paddle 2
    input wire[9:0] paddle2_x2,	//x_2 coordinate of paddle 2
    input wire[9:0] ball_x,	//x coordinate of the ball
    input wire[9:0] ball_y,	//y coordinate of the ball
    input wire[9:0] hbp, 	// end of horizontal back porch
    input wire[9:0] hfp, 	// beginning of horizontal front porch
    input wire[9:0] vbp, 		// end of vertical back porch
    input wire[9:0] vfp, 	// beginning of vertical front porch
    input wire[9:0] hc,
    input wire[9:0] vc,
    input wire[9:0] ball_radius, 
    input wire[9:0] paddle_height,
    output reg[1:0] color		// the color code.
);

wire[19:0] ball_diff_x = hc >= ball_x + hbp? hc - ball_x - hbp : ball_x + hbp - hc;
wire[19:0] ball_diff_y = vc >= ball_y + vbp? vc - ball_y - vbp : ball_y + vbp - vc;
wire[19:0] ball_square = ball_radius * ball_radius;

always @(*)
begin
    if (hc < hbp || hc > hfp)
    color <= 0;
    else if (vc < vbp || vc > vfp)
    color <= 0;
    else if (((hc >= hbp - 1) && (hc <= hbp + 1))|| ((hc >= hfp -1) && (hc <= hfp + 1)))
    color <= 1;
    else if (vc == vbp || vc == vfp)
    color <= 1;
    else if(( hc >= paddle1_x1+ hbp) && (hc <= paddle1_x2 + hbp) && (vc < (paddle_height + vbp)) || 
    ((hc >= paddle2_x1 + hbp) && (hc <= paddle2_x2 + hbp) && (vc > (vfp - paddle_height))))
    color <= 1;
    else if(ball_diff_x * ball_diff_x  + ball_diff_y * ball_diff_y < ball_square)
    color <= 2'b10;
    else
    color <= 0;
end


endmodule
