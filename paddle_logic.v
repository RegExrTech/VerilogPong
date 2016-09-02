`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:51 04/13/2016 
// Design Name: 
// Module Name:    paddle_logic 
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
module paddle_logic(
    input[1:0] paddle1,
    input[1:0] paddle2,
    input clk,
    input reset,
	 input game_end,
	 input[9:0] paddle1_width,
	 input[9:0] paddle2_width,
    output reg[9:0] paddle1_x1,	//x coordinate of paddle 1
    output reg[9:0] paddle1_x2,	//ycoordinate of paddle 1
    output reg[9:0] paddle2_x1,	//x_1 coordinate of paddle 2
    output reg[9:0] paddle2_x2	//x_2 coordinate of paddle 2
);

parameter[1:0] left = 1;
parameter[1:0] right = 2;
reg[9:0] right_most1 = 640;
reg[9:0] right_most2 = 640;
parameter[9:0] paddle_default = 260;
parameter[9:0] paddle_width_default = 150;

parameter[9:0] distance = 2;

reg[9:0] paddle_1 = 100;
reg[9:0] paddle_2 = 100;

always @(posedge clk)
begin
    if(reset) begin
        paddle_1 <= paddle_default;
    end
    else 
    begin
        if(paddle1 == left) begin
            if(paddle_1 > 1)
                paddle_1 <= paddle_1 - distance;
            else
        paddle_1 <= paddle_1; end
        else if(paddle1 == right) begin
            if(paddle_1 < right_most1)
                paddle_1 <= paddle_1 + distance;
            else
        paddle_1 <= paddle_1; end
        else begin
        paddle_1 <= paddle_1; end
    end
end

always @(posedge clk)
begin
    if(reset) begin
        paddle_2 <= paddle_default;
    end
    else 
    begin
        if(paddle2 == left) begin
            if(paddle_2 > 1)
                paddle_2 <= paddle_2 - distance;
            else
        paddle_2 <= paddle_2; end
        else if(paddle2 == right) begin
            if(paddle_2 < right_most2)
                paddle_2 <= paddle_2 + distance;
            else
        paddle_2 <= paddle_2; end
        else begin
        paddle_2 <= paddle_2; end
    end
end

always @(posedge clk)
begin
	right_most1 <= 640 - paddle1_width;
	right_most2 <= 640 - paddle2_width;
    //if(!reset) 
    //begin
        paddle1_x1 <= game_end? paddle1_x1: paddle_1;
        paddle1_x2 <= game_end? paddle1_x2: (paddle_1 + paddle1_width);
        paddle2_x1 <= game_end? paddle2_x1:  paddle_2;
        paddle2_x2 <= game_end? paddle2_x2: (paddle_2 + paddle2_width);
    //end
    //else begin
    //    paddle1_x1 <= paddle_default;
    //    paddle1_x2 <= paddle_default + 150;
    //    paddle2_x1 <= paddle_default;
    //    paddle2_x2 <= paddle_default + 150;
   //end
end
endmodule
