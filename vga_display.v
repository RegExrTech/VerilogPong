`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Keyi Zhang
// 
// Create Date:    23:34:05 04/08/2016 
// Design Name: 
// Module Name:    vga_display 
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
module vga_display(
    input dclk,
    input wire[9:0] paddle1_x1,	//x coordinate of paddle 1
    input wire[9:0] paddle1_x2,	//ycoordinate of paddle 1
    input wire[9:0] paddle2_x1,	//x_1 coordinate of paddle 2
    input wire[9:0] paddle2_x2,	//x_2 coordinate of paddle 2
    input wire[9:0] ball_x,	//x coordinate of the ball
    input wire[9:0] ball_y,	//y coordinate of the ball
    output wire hsync,	// horizontal sync output
    output wire vsync,	//vertical sync output
    output reg[2:0] red,	// red vga output
    output reg[2:0] green,	// green vga output
    output reg[2:0] blue	// blue vga output
);

     // video structure constants
     parameter hpixels = 800;// horizontal pixels per line
     parameter vlines = 431; // vertical lines per frame
     parameter hpulse = 96; 	// hsync pulse length
     parameter vpulse = 2; 	// vsync pulse length
     parameter hbp = 144; 	// end of horizontal back porch
     parameter hfp = 784; 	// beginning of horizontal front porch
     parameter vbp = 31; 		// end of vertical back porch
     parameter vfp = 391; 	// beginning of vertical front porch

    // active horizontal video is therefore: 784 - 144 = 640
    // active vertical video is therefore: 391 - 31 = 360

    // rendering constants
    parameter paddle_height = 7;
    parameter ball_radius = 5; // need to change to actually make it a ball
    parameter bit_white_3 = 3'b111;	// 3 bit white color
    parameter bit_white_2 = 2'b11;	// 2 bit white color
    parameter bit_black_3 = 3'b000;	// 3 bit black color
    parameter bit_black_2 = 2'b00;	// 2 bit black color
    parameter bit_yellow_3 = 3'b110;	// 3 bit black color

    // rendering offsets
    // wire[9:0] paddle1_x1_d = paddle1_x1 + hbp;	//x_1 coordinate of paddle 1
    // wire[9:0] paddle1_x2_d = paddle1_x2 + vbp;	//x_2 coordinate of paddle 1
    // wire[9:0] paddle2_x1_d = paddle2_x1 + hbp;	//x_1coordinate of paddle 2
    // wire[9:0] paddle2_x2_d = paddle2_x2 + vbp;	//x_2 coordinate of paddle 2
    // wire[9:0] ball_x_d = ball_x + hbp;	//x coordinate of the ball
    // wire[9:0] ball_y_d = ball_x + hbp;	//y coordinate of the ball


    // registers for storing the horizontal & vertical counters
    reg [9:0] hc = 10'b0;
    reg [9:0] vc = 10'b0;

    // fix the strange verilog requirement
    //reg [2:0] red_r;
    //reg [2:0] green_r;
    //reg [1:0] blue_r;

    //initial hc = 10'b0;
    // initial hc = 10'b0;

    always @(posedge dclk)
    begin
        begin
            // keep counting until the end of the line
            if (hc < hpixels - 1)
                hc <= hc + 1;
            else
            // When we hit the end of the line, reset the horizontal
            // counter and increment the vertical counter.
            // If vertical counter is at the end of the frame, then
            // reset that one too.
            begin
                hc <= 0;
                if (vc < vlines - 1)
                    vc <= vc + 1;
                else
                    vc <= 0;
            end

        end
    end

    // generate sync pulses (active low)
    // ----------------
    // "assign" statements are a quick way to
    // give values to variables of type: wire
    assign hsync = (hc < hpulse) ? 0:1;
    assign vsync = (vc < vpulse) ? 0:1;

    wire[1:0] color;
    should_display SHOULD_DISPLAY(
        .paddle1_x1(paddle1_x1),	//x coordinate of paddle 1
        .paddle1_x2(paddle1_x2),	//ycoordinate of paddle 1
        .paddle2_x1(paddle2_x1),	//x_1 coordinate of paddle 2
        .paddle2_x2(paddle2_x2),	//x_2 coordinate of paddle 2
        .ball_x(ball_x),	//x coordinate of the ball
        .ball_y(ball_y),	//y coordinate of the ball
        .hbp(hbp), 	// end of horizontal back porch
        .hfp(hfp), 	// beginning of horizontal front porch
        .vbp(vbp), 		// end of vertical back porch
        .vfp(vfp), 	// beginning of vertical front porch
        .hc(hc),
        .vc(vc),
        .ball_radius(ball_radius), 
        .paddle_height(paddle_height),
        .color(color)
    );	

    always @(*)
    begin
        // first check if we're within vertical active video range

        case (color)
            2'b01:
            begin
                red <= bit_white_3;
                green <= bit_white_3;
                blue <= bit_white_2;
            end
            2'b10:
            begin
                red <= bit_white_3;
                green <= bit_yellow_3;
                blue <= bit_black_2;
            end
            default:
            begin
                red <= bit_black_3;
                green <= bit_black_3;
                blue <= bit_black_2;
            end
        endcase
    end


    endmodule
