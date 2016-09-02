`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:23:52 04/16/2016 
// Design Name: 
// Module Name:    ball_logic 
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
module ball_logic(
    input clk,
    input reset,
	 input wire[9:0] paddle1_x1,	//x coordinate of paddle 1
    input wire[9:0] paddle1_x2,	//ycoordinate of paddle 1
    input wire[9:0] paddle2_x1,	//x_1 coordinate of paddle 2
    input wire[9:0] paddle2_x2,	//x_2 coordinate of paddle 2
    output reg[9:0] ball_x,
    output reg[9:0] ball_y,
	 output reg ball_sound,
	 output reg[1:0] paddle_hit,
	 output reg game_end
);

    // use a customized and standalone clock
    //reg[17:0] counter;
    //always @(posedge clk)
    //    counter = counter + 1;

    wire bclk;
    //assign bclk = &counter;	
	 assign bclk = clk;	
	
    reg x_increase = 1;
    reg y_increase = 1;
    // parameter[2:0] speed = 2;
    // parameter signed [2:0] neg_speed = -2;
    parameter[9:0] width = 640;
    parameter[9:0] height = 360;

    parameter[9:0] x_default = 20;
    parameter[9:0] y_default = 20;

    reg [9:0] x = x_default;
    reg [9:0] y = y_default;

    always @(posedge bclk)
    begin
        if(reset) begin
            x <= x_default ;
            y <= y_default ;
            x_increase <= 1;
            y_increase <= 1;
				ball_sound <= 0;
				game_end <= 0;
				paddle_hit <= 2'b00;
        end 
        else begin
            if(x <= 2 && x_increase == 0) 
				begin
                x  <= x + 1;
					x_increase <= 1; 
					ball_sound <= 1;
					paddle_hit <= 2'b00;
				end
            else if (x >= width - 4 && x_increase  ==1) 
				begin
                x  <= x - 1;
					x_increase <= 0; 
					ball_sound <= 1; 
					paddle_hit <= 2'b00;
					end
            else begin
                x  <= x_increase == 1? (x + 1): (x - 1 );
					x_increase <= x_increase; 
					ball_sound <= 0;
					paddle_hit <= 2'b00;
					end
            if(y <= 5 && y_increase == 0)
				begin
					if(x < paddle1_x1 || x > paddle1_x2)
					begin
						y  <= y;
						y_increase <= 0; 
						ball_sound <= 0;
						game_end <= 1;
						paddle_hit <= 2'b00;
					end
					else begin
						y  <= y + 1;
						y_increase <= 1; 
						ball_sound <= 1;
						paddle_hit <= 2'b01;
					end
				end
            else if (y >= height - 5 && y_increase  == 1) 
				begin
					if(x < paddle2_x1 || x > paddle2_x2)
					begin
						y  <= y;
						y_increase <= 0; 
						ball_sound <= 0;
						game_end <= 1;
						paddle_hit <= 2'b00;
					end
					else begin
						y  <= y - 1;
						y_increase <= 0; 
						ball_sound <= 1;
						paddle_hit <= 2'b10;
					end
				end
            else begin
            y  <= y_increase == 1? (y + 1): (y - 1 );
            y_increase <= y_increase; 
				ball_sound <= 0; 
				paddle_hit <= 2'b00;
				end
        end
    end

    // always @(posedge clk)
    // begin
    // 	x <= x + x_increase == 1? 1 : - 1;
    // 	y <= y + y_increase == 1? 1 : - 1;
    // end
    always @(posedge clk)
    begin
        if(reset)
        begin
            ball_x <= x_default ;
            ball_y <= y_default ;
        end 
        else begin
				if(game_end) begin
					ball_x <= ball_x ;
					ball_y <= ball_y ;
				end
				else begin
					ball_x <= x ;
					ball_y <= y ;
				end
        end
    end

    endmodule
