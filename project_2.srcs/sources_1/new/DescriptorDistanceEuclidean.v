`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/22 10:51:31
// Design Name: 
// Module Name: DescriptorDistanceEuclidean
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


module DescriptorDistanceEuclidean(
	input clk,
	input rst,
	input in_valid_float_a,
	input in_valid_float_b,
	input [31:0]in_data_float_a,
	input [31:0]in_data_float_b,
	output out_valid_float_dist,
	output [31:0]out_data_float_dist
    );
           
    wire [31:0]in_data_fixed_a;
    wire [31:0]in_data_fixed_b;
    wire in_valid_fixed_a;
    wire in_valid_fixed_b;
    
    reg [47:0]fixed_sum;
	reg [9:0]i;
	
    reg in_valid_fixed_sqrt;
    wire out_valid_fixed_sqrt;
    wire [47:0]in_data_fixed_sqrt;
	wire [24:0]out_data_fixed_sqrt;
	wire [31:0]temp;
	
	reg [47:0] v;
	reg v_valid;
	
	assign in_data_fixed_sqrt = (2 << 28) - 2 * fixed_sum;
	
    assign temp = { 7'b0, out_data_fixed_sqrt } << 14;
	
	float2fixed uut_float2fixed_a(
        .aclk(clk),
        .s_axis_a_tvalid(in_valid_float_a),
        .s_axis_a_tdata(in_data_float_a),
        .m_axis_result_tvalid(in_valid_fixed_a),
        .m_axis_result_tdata(in_data_fixed_a)
    );

    float2fixed uut_float2fixed_b(
        .aclk(clk),
        .s_axis_a_tvalid(in_valid_float_b),
        .s_axis_a_tdata(in_data_float_b),
        .m_axis_result_tvalid(in_valid_fixed_b),
        .m_axis_result_tdata(in_data_fixed_b)
    );
    
    sqrt uut_sqrt (
        .aclk(clk),                                 
        .s_axis_cartesian_tvalid(in_valid_fixed_sqrt),  
        .s_axis_cartesian_tdata(in_data_fixed_sqrt),    
        .m_axis_dout_tvalid(out_valid_fixed_sqrt),
        .m_axis_dout_tdata(out_data_fixed_sqrt)   
    ); 

    fixed2float uut_fixed2float (
        .aclk(clk),
        .s_axis_a_tvalid(out_valid_fixed_sqrt),
        .s_axis_a_tdata(temp),
        .m_axis_result_tvalid(out_valid_float_dist),
        .m_axis_result_tdata(out_data_float_dist)
    );
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v <= 0;
            v_valid <= 0;
		end
		else if (in_valid_fixed_a && in_valid_fixed_b) begin
            v <= in_data_fixed_a * in_data_fixed_b >> 28;
            v_valid <= 1;    
		end
		else begin
		    v_valid <= 0;
		end
    end
    
	always @(posedge clk or negedge rst) begin
		if (!rst) begin
            fixed_sum <= 0;
            i <= 0;
            in_valid_fixed_sqrt <= 0;
		end
		else if (v_valid && i < 256) begin
            fixed_sum <= fixed_sum + v;
            i <= i + 1;
		end
		else if (i >= 256) begin
		    in_valid_fixed_sqrt <= 1;
		end
	end
	
endmodule
