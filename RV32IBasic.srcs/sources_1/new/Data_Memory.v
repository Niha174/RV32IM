`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2024 06:47:26 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(clk,reset,Address,WData,RData,WriteEnable,ReadEnable);
         input clk;
         input reset;
         input [31:0] Address;
         input [31:0] WData;
         input WriteEnable;
         input ReadEnable;
         output reg[31:0] RData;
         reg [31:0] data_mem [256:0]; // 512 memory locations
         always @(posedge clk) begin
             if (WriteEnable) begin
                  data_mem[Address[7:0]] <= WData;
             end
             else begin
                  data_mem <= data_mem;
             end
         end  
         always @(negedge clk) begin
                 if(reset) begin
                       RData <= 32'b0;
         end
         else begin
                 if (ReadEnable) begin
                        RData <= data_mem[Address[7:0]];
                 end
             end
         end
  
endmodule
