module paddle_hit_logic(input [1:0] hit,
								input reset,
								output reg [9:0] paddle1_width,
								output reg [9:0] paddle2_width);
								
	parameter paddle1_hit = 2'b10;
	parameter paddle2_hit = 2'b01;
	parameter paddle_default = 150;
	parameter paddle_min = 50;
	
	reg [9:0] p1_width = 150;
	reg [9:0] p2_width = 150;

	wire has_hit = ^hit;
	
	always @(posedge has_hit, posedge reset)
		if (reset) begin p1_width <= 150; p2_width <= 150; end
		else
			case (hit)
				paddle1_hit: 
					begin
						if (p1_width > paddle_min) p1_width <= p1_width - 11;
						else p1_width <= p1_width;
					end
				paddle2_hit:
					begin
						if (p2_width > paddle_min) p2_width <= p2_width - 11;
						else p2_width <= p2_width;
					end
				default: 
					begin 
						p1_width <= p1_width; 
						p2_width <= p2_width; 
					end
			endcase
	
	wire change = has_hit | reset;
			
	always @(posedge change) begin
		paddle1_width <= p1_width;
		paddle2_width <= p2_width;
	end

endmodule