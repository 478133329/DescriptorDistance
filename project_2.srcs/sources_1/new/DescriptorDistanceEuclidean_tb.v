`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/21 12:53:22
// Design Name: 
// Module Name: DescriptorDistanceEuclidean_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DescriptorDistanceEuclidean_tb();
    reg [31:0]in_data_float_a;
    reg [31:0]in_data_float_b;
    reg clk;
    reg rst;
    reg in_valid_float_a;
    reg in_valid_float_b;
    wire out_valid_float_dist;
    wire [31:0]out_data_float_dist;
    
    // reg data_flow_work;
    // reg [31:0]count;
    DescriptorDistanceEuclidean uut(
        .clk(clk),
	    .rst(rst),
	    .in_valid_float_a(in_valid_float_a),
	    .in_valid_float_b(in_valid_float_b),
	    .in_data_float_a(in_data_float_a),
	    .in_data_float_b(in_data_float_b),
	    .out_valid_float_dist(out_valid_float_dist),
	    .out_data_float_dist(out_data_float_dist)
	);
	
    always #10 clk <= ~clk;
    
    initial begin
        clk <= 0;
        rst <= 1;
        in_valid_float_a <= 0;
        in_valid_float_b <= 0;
        in_data_float_a <= 0;
        in_data_float_b <= 0;
        // data_flow_work <= 0;
        // count <= 0;
        
        #100
        rst <= 0;
        #100
        rst <= 1;
        #100
        in_data_float_a <= 32'h3AC49BA6;
        in_data_float_b <= 32'h3D03126F;
        in_valid_float_a <= 1;
        in_valid_float_b <= 1;
    end
endmodule
