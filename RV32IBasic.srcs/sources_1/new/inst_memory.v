`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2024 06:44:04 PM
// Design Name: 
// Module Name: inst_memory
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


module inst_memory(
    input clk,
    input reset,
    input [7:0] Address,
    output reg[31:0] instruction
    );
    reg [7:0] mem [255:0];                                                         
    always @(posedge clk)begin                                                     
      if(reset)                                                                    
        instruction<=32'b0;                                                        
      else                                                                         
        instruction<={mem[Address],mem[Address+1],mem[Address+2],mem[Address+3]};  
    end                                                                            
                                                                                   
    initial begin                                                                 
          $readmemh("Memory.mem",mem);  // Read Memory File                            
    end                                                                            
endmodule