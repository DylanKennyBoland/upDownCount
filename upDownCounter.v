// Author: Dylan Boland (Student)
// Date: 31/07/2022
//
// This file contains a description of an up-down counter, with an
// optional "load" signal that is active-high - i.e., if load == 1, then
// the counter is loaded with whatever 4 bits are on the "value" input port
// pin. It will then count up or down depending on whether "up" or "down" are
// 1 or 0 (high or low).
//
//
module upDownCounter (
	input wire reset, // reset signal for the counter; active-high (i.e. reset = 1 will reset the counter)
	input wire clk, // the input clock; drives the flip-flops
	input wire up, // the "up" signal; set to 1 in order to count up
	input wire down, // the "down" signal; set to 1 to count down
	input wire load, // signal to indicate that the counter should be loaded with value on "value" input pin
	input wire [3:0] value, // the "value" input port pin
	output reg [3:0] count // the counter value, which is 4 bits wide
	);
	
	// ==== nextCount logic ====
	reg [3:0] nextCount; // making it type "reg" so we can describe inside a "process" block
	always @ (load, up, down, count) // sensitivity list does not include clk, as nextCount is output of multiplexor
		if (load) // load signal gets priority over "up" and "down"
			nextCount = value;
		else if (up & ~down) // i.e., up == 1, and down == 0
			nextCount = count + 4'd1; // increment the count by decimal 1 (using 4-bit representation of 1)
		else if (~up & down)
			nextCount = count - 4'd1; // decrement the count by decimal 1 (using 4-bit representation of 1)
		else
			nextCount = count;
	
	// ==== count logic ====
	// we will use a process block:
	always @ (posedge clk or posedge reset) // reset is in sensitivity list, meaning we have asynchronous reset
		if (reset) // i.e., if reset == 1
			count <= 4'd0; // count should become decimal 0, and be 4 bits wide
		else // if at the positive rising edge of the clock signal...
			count <= nextCount;

endmodule
	