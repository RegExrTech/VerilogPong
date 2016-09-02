`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:52:13 04/08/2016 
// Design Name: 
// Module Name:    pong_main 
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
module pong_main(
    input clk,
    input hard_reset,
    //input P1Left,
    //input P1Right,
    //input P2Left,
    //input P2Right,
	 
	 // nes controller
	 input data1,
	 input data2,
	 output c_clk,
	 output latch,
     //input[1:0] btn1,
     //input[1:0] btn2,
     output wire hsync,	// horizontal sync output
     output wire vsync,	//vertical sync output
     output wire[2:0] red,	// red vga output
     output wire[2:0] green,	// green vga output
     output wire[2:0] blue,	// blue vga output
	  output wire speaker
 );
 
 
 wire[9:0] paddle1_x1; // = 100;	//x_1 coordinate of paddle 1
 wire[9:0] paddle1_x2; // = 300;	//x_2 coordinate of paddle 1
 wire[9:0] paddle2_x1; // = 100;	//x_1 coordinate of paddle 2
 wire[9:0] paddle2_x2; // = 300;	//x_2 coordinate of paddle 2
     //parameter[9:0] ball_x = 100;	//x coordinate of the ball
     //parameter[9:0] ball_y = 200;	//y coordinate of the ball
     // parameter btn1 = 0;
     // parameter btn2 = 0;
     wire[1:0] btn1;
     wire[1:0] btn2;
     
     wire[9:0] ball_x;
     wire[9:0] ball_y;
	  wire ball_sound;
     
     wire[9:0] paddle1_width;
	  wire[9:0] paddle2_width;
	  wire[1:0] paddle_hit;
	  wire game_end;
	  wire soft_reset;
	  
	  wire[1:0] other;
	  wire _test_other = &other;
     //wire reset = 0;	// reset button
     
     
     wire gclk;
	  
	  
	  // game start logic here
	  game_reset RESET(
			.game_end(game_end),
			.other(_test_other),
			.hard_reset(hard_reset),
			.reset(soft_reset)
		);
     
     game_clock GMAE_CLOCK(
         .clk(clk),
         .gclk(gclk)
     );
     
     ball_logic BALL_LOGIC(
         .clk(gclk),
         .reset(soft_reset),
			.paddle1_x1(paddle1_x1),
         .paddle1_x2(paddle1_x2),
         .paddle2_x1(paddle2_x1),
         .paddle2_x2(paddle2_x2),
         .ball_x(ball_x),
         .ball_y(ball_y),
			.ball_sound(ball_sound),
			.paddle_hit(paddle_hit),
			.game_end(game_end)
     );
	  
	  paddle_hit_logic PADDLE_HIT(
			.hit(paddle_hit),
			//.clk(gclk),
			.reset(soft_reset),
			.paddle1_width(paddle1_width),
			.paddle2_width(paddle2_width)
			);
	  
	  
	  beep_for_wall WALL_BEEP(
			.clk(clk),
			.e(ball_sound),
			.game_end(game_end),
			.speaker(speaker)
			);
			
     
        //paddle_test PADDLE_TEST(
        //.clk(gclk),
        //.tclock1(btn1),
        //.tclock2(btn2)
        //);
//        controller CONTROLLER1(
//            .P1Left(P1Left),
//            .P1Right(P1Right),
//            .clk(gclk),
//        //.reset(reset),
//        .paddle(btn1));
		  
		 nes_controller CONTROLLER(
      .data1(data1),
		.data2(data2),
		.clk(clk),
		.c_clk(c_clk),
		.latch(latch),
		.paddle1(btn1),
		.paddle2(btn2),
		.other(other)
    );
    
    
    paddle_logic PADDLE_LOGIC(
        .paddle1(btn1),
        .paddle2(btn2),
        .clk(gclk),
		  .game_end(game_end),
		  .paddle1_width(paddle1_width),
		  .paddle2_width(paddle2_width),
        .reset(soft_reset),
        .paddle1_x1(paddle1_x1),
        .paddle1_x2(paddle1_x2),
        .paddle2_x1(paddle2_x1),
        .paddle2_x2(paddle2_x2)
    );
    
    
    wire dclk;
    
    display_clock DCLK(
        .clk(clk),
        .dclk(dclk)
    );
    
    vga_display VGA(
        .dclk(dclk),
        .paddle1_x1(paddle1_x1),
        .paddle1_x2(paddle1_x2),
        .paddle2_x1(paddle2_x1),
        .paddle2_x2(paddle2_x2),
        .ball_x(ball_x),
        .ball_y(ball_y),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );
    
    
    endmodule
