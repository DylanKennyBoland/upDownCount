// Author: Dylan Boland (Student)
// Date: 31/07/2022
//
// This file contains a testbench for the four-bit up-down counter
// module (upDownCounter).
//
//
module TB_upDownCounter; // the testbench module name
	// ==== Define the internal stimulus signals ====
	// First, the testbench signals that will be connected to the inputs of the design module
	// Unless otherwise specified, all these reg. input signals will be 1-bit wide , as needed
	reg reset; // type reg., as reset is an input
	reg clk;
	reg load;
	reg up;
	reg down;
	reg [3:0] value; // "value" is a 4-bit wide input
	wire [3:0] count; // the output of the counter module will drive this wire signal... also called "count"
	
	// ==== Instantiate the Design Module - the Device Under Test (DUT) ====
	upDownCounter dut ( // module name: upDownCounter, instance name: dut
		.reset(reset),
		.clk(clk),
		.load(load),
		.up(up),
		.down(down),
		.value(value),
		.count(count)
		);
	
	// ==== Generate the clock (clk) signal ====
	initial
	begin
		clk = 1'b0; // clk is intially 0, and is 1-bit wide
		forever
			#10 clk = ~clk; // waiting 10 timescales before inverting clock value; this will generate a 50 MHz clock
	end
	
	initial
	begin
	// ==== Initialise signal values and Generate Stimulus ====
		reset = 1'b0;
		value = 4'd4;
		load = 1'b0;
		up = 1'b0;
		down = 1'b0;
		// now we can wait some clock cycles and begin changing signals (create stimulus)
		#15 load = 1'b1; // load goes high
		#20 load = 1'b0; // load goes low again
		#10 up = 1'b1; // up goes to 1; we should start counting up now
		#30 reset = 1'b1; // reset the count value - does it become 0?
		#10 reset = 1'b0; // let reset signal go low again
	
		// ==== End the Simulation ====
		#200;
		$stop;
	end
	
endmodule
