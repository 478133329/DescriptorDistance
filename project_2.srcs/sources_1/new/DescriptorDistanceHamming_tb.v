`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/21 16:52:02
// Design Name: 
// Module Name: DescriptorDistanceHamming_tb
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


module DescriptorDistanceHamming_tb();
    reg clk;
    reg rst;
    
    
    reg [31:0] in_data_a;
    reg [31:0] in_data_b;
   
    reg in_valid_a;
    reg in_valid_b;
   
    wire out_valid_dist;
    wire [31:0]out_data_dist;
    
    DescriptorDistanceHamming uut(
        .clk(clk),
        .rst(rst),
        .in_valid_a(in_valid_a),
        .in_valid_b(in_valid_b),
        .in_data_a(in_data_a),
        .in_data_b(in_data_b),
        .out_valid_dist(out_valid_dist),
        .out_data_dist(out_data_dist)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk <= 0;
        rst <= 1;
        #10
        rst <= 0;
        #10
        rst <= 1;
        #20
        in_valid_a <= 1;
        in_valid_b <= 1;
        in_data_a = 32'd4;
        in_data_b = 32'd1114;
        #10
        in_data_a = 32'd2;
        in_data_b = 32'd322;
        #10
        in_data_a = 32'd7;
        in_data_b = 32'd47;
        #10
        in_data_a = 32'd1;
        in_data_b = 32'd1;
        #10
        in_data_a = 32'd2;
        in_data_b = 32'd12;
        #10
        in_data_a = 32'd46;
        in_data_b = 32'd46;
        #10
        in_data_a = 32'd2712;
        in_data_b = 32'd12;
        #10
        in_data_a = 32'd512;
        in_data_b = 32'd92;
    end  
endmodule
