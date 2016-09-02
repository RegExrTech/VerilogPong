`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:38 04/20/2016 
// Design Name: 
// Module Name:    nes_controller 
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
// adopted from https://github.com/michael-swan/NES-Controller-SIPO
module nes_controller(
	input data1,
	input data2,
	input clk,
	output c_clk,
	output latch,
	output[1:0] paddle1,
	output[1:0] paddle2,
	output[1:0] other
    );
	 
	reg [7:0] button_state1;
	reg [7:0] button_state2;
	
	// Clock divider register size
	parameter DIVIDER_EXPONENT = 13;
	
	// Generate a clock for generating the data clock and sampling the controller's output
	reg [DIVIDER_EXPONENT:0] sample_count;
	wire sample_clock = sample_count[DIVIDER_EXPONENT];
	always @(posedge clk) sample_count <= sample_count + 1;
	
	// Keep track of the stage of the cycle
	reg [3:0] cycle_stage;
	reg [7:0] data_1;
	reg [7:0] data_2;
	// Generate control signals for the three phases
	wire latch_phase = cycle_stage == 0;
	wire data_phase = cycle_stage >= 1 & cycle_stage <= 8;
	wire end_phase = cycle_stage == 9;
	
	// Handle inputs from the controller
	always @(posedge sample_clock) begin
		   if(latch_phase) 
			begin 
				data_1 <= 8'b11111111; 
			end
			else if(data_phase)  
			begin 
			data_1 <= {data1, data_1[7:1]}; 
			end
			else if(end_phase) begin
			button_state1[7:0] <= data_1;
		end
		
	end
	
	always @(posedge sample_clock) begin 
		cycle_stage <= cycle_stage + 1;
		if(end_phase) cycle_stage <= 4'h0;
		end
	
		// Handle inputs from the controller
	always @(posedge sample_clock) begin
		   if(latch_phase) 
			begin 
				data_2 <= 8'b11111111; 
			end
			else if(data_phase)  
			begin 
			data_2 <= {data2, data_2[7:1]}; 
			end
			else if(end_phase) begin
			button_state2[7:0] <= data_2;
		end
	end

	// Generate output signals
	assign latch = latch_phase;
	assign c_clk = data_phase & sample_clock;
	
	
	assign paddle1[0] = ~(button_state1[6]) | ~(button_state1[4]);
	assign paddle1[1] = ~(button_state1[7]) | ~(button_state1[5]);
	assign paddle2[0] = ~(button_state2[5]) | ~(button_state2[3]);
	assign paddle2[1] = ~(button_state2[6]) | ~(button_state2[4]);
	
	assign other[0] = ~(&button_state1[3:0]);
	assign other[1] = ~(&button_state2[2:0]) | ~button_state2[7];
	
endmodule
