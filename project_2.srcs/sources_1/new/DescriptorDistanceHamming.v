`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/22 15:51:52
// Design Name: 
// Module Name: DescriptorDistanceHamming
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


module DescriptorDistanceHamming(
	input clk,
	input rst,
	input in_valid_a,
	input in_valid_b,
	input [31:0]in_data_a,
	input [31:0]in_data_b,
	output  out_valid_dist,
	output  [31:0]out_data_dist
    );
    
    reg [4:0]i;
	reg [31:0]sum;
	reg [31:0]v1;
	reg [31:0]v1_delay; 
	reg [31:0]v2; 
	reg [31:0]v3;
    reg [31:0]v4;
    reg [31:0]v5;
    reg [31:0]v6;
    reg [31:0]v6_delay;
    reg [31:0]v7;
    reg [31:0]v8;
    reg [31:0]v9;
    
	reg sum_valid;
    reg v1_valid;
    reg v2_valid;
    reg v3_valid;
    reg v4_valid;
    reg v5_valid;
    reg v6_valid;
    reg v7_valid;
    reg v8_valid;
    reg v9_valid;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v1 <= 0;
            v1_valid <= 0;
        end
        else if (in_valid_a && in_valid_b) begin
            v1 <= in_data_a ^ in_data_b;
            v1_valid <= 1;
        end
        else begin
            v1_valid <= 0;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v1_delay <= 0;
            v2 <= 0;
            v2_valid <= 0;
        end
        else if (v1_valid) begin
            v1_delay <= v1;
            v2 <= (v1 >> 1) & 32'h55555555;
            v2_valid <= 1;
        end
        else begin
            v2_valid <= 0;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v3 <= 0;
            v3_valid <= 0;
        end
        else if (v2_valid) begin
            v3 <= v1_delay - v2;
            v3_valid <= 1;
        end
        else begin
            v3_valid <= 0;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v4 <= 0;
            v5 <= 0;
            v5_valid <= 0;
        end
        else if (v3_valid) begin
            v4 <= v3 & 32'h33333333;
            v5 <= (v3 >> 2) & 32'h33333333;
            v5_valid <= 1;
        end
        else begin
            v5_valid <= 0;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v6 <= 0;
            v6_valid <= 0;
        end
        else if (v5_valid) begin
            v6 <= v4 + v5;
            v6_valid <= 1;
        end
        else begin
            v6_valid <= 0;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v6_delay <= 0;
            v7 <= 0;
            v7_valid <= 0;
        end
        else if (v6_valid) begin
            v6_delay <= v6;
            v7 <= v6 >> 4;
            v7_valid <= 1;
        end
        else begin
            v7_valid <= 0;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v8 <= 0;
            v8_valid <= 0;
        end
        else if (v7_valid) begin
            v8 <= v6_delay + v7;
            v8_valid <= 1;
        end
        else begin
            v8_valid <= 0;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            v9 <= 0;
	        v9_valid <= 0;
        end
        else if (v8_valid) begin
            v9 <= ((v8 & 32'hF0F0F0F) *  32'h1010101) >> 24;
            v9_valid <= 1;
        end
        else begin
            v9_valid <= 0;
        end
    end 
    
	always @(posedge clk or negedge rst) begin
        if (!rst) begin
        	i <= 0;
            sum <= 0;
	        sum_valid <= 0;
        end
        else if (v9_valid && i < 8) begin           
            sum <= sum + v9;
            i <= i + 1;
		end
		else if (i >= 8) begin
		    sum_valid <= 1;
		end
	end

    assign out_valid_dist = sum_valid;
	assign out_data_dist = sum;

endmodule
