`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2024 07:11:56 PM
// Design Name: 
// Module Name: Top_Module
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


module Top_Module(clk,reset,op_WriteBack);
    input clk;
    input reset;
    output [31:0] op_WriteBack;
    
//<--------------------------Signals----------------------------->//
    wire [31:0] Instruction;
    wire [31:0] w_PC_Add; 
    wire  [31:0]w_PC_Add_temp ;
    wire w_Write_en;
    wire [1:0] w_ALUSrc;
    wire [31:0] w_Data_out2;
    wire [31:0] w_imm;
    wire [31:0] w_Data_out1;
    wire [31:0] w_Mux_Data; 
    wire [1:0]  w_ALUOp;
    wire [5:0] w_ALUCtrl;
    wire [31:0] w_Read_Data;
    wire [1:0] w_sel_MemtoReg;
   // wire [31:0] w_Data_in;
    wire w_MemRead;
    wire w_MemWrite;
    wire [31:0] w_alu_output;
    wire [31:0] w_Muc_PC;
 //   wire w_PCSrc;
    wire [31:0] op_ADD_J;
    wire w_Branch_En;
    wire w_op_Branch_Unit;
    wire [31:0] w_op_shift_left;
    wire [31:0] pc_temp ;
    wire w_Jump;
//<-------------------------------------------------------------->//  
    // 1.> Instantiate Control Module :
    Control_Unit CU(.Instruction(Instruction),
    .Write_en(w_Write_en),      
    .ALUSrc(w_ALUSrc),       
    .ALUOp(w_ALUOp),
    .MemtoReg(w_sel_MemtoReg),
    .MemRead(w_MemRead),
    .MemWrite(w_MemWrite),
   // .PCSrc(w_PCSrc),
    .Branch_En(w_Branch_En),
    .Jump(w_Jump)        
    );
    // 2.> Instantiate Register file Module
    Reg_file Reg(
    .Read_Reg1(Instruction[19:15]),
    .Read_Reg2(Instruction[24:20]),
    .Write_Reg(Instruction[11:7]),
    .Write_en(w_Write_en),
    .clk(clk),
    .reset(reset),
    .Data_out1(w_Data_out1),
    .Data_out2(w_Data_out2),
    .Data_in(op_WriteBack)
    );
    // 3.> Instantiate Immediate Generator file Module
    Immediate Imm(
    .instruction(Instruction[31:0]),
    .immediate(w_imm));
    // 4.> Instantiate MUX between register file and immediate file
    Reg_Mux_ALU M0(
    .ip_Data_out2(w_Data_out2),  
    .ip_Imm_Gen(w_imm),     
    .sel_ALUSrc(w_ALUSrc),            
    .Data_out(w_Mux_Data),
    .op_PC(w_PC_Add_temp)  
    );
    // 5.> Instantiate ALU 
    ALU_Unit AU(
    .Read_data1(w_Data_out1),    
    .Mux_Data(w_Mux_Data),      
    .ALU_Control(w_ALUCtrl),    
    .ALU_Result(w_alu_output)
    );
    // 6.> Instantiate ALU Control Unit
    ALU_CTRL_UNIT AC(
    .Instruction(Instruction[31:0]),
    .ALUOp(w_ALUOp),
    .ALUCtrl(w_ALUCtrl)
    );
    // 7.> Instantiate of Data Memory
    Data_Memory DM(
    .clk(clk),
    .reset(reset),    
    .Address(w_alu_output),
    .WData(w_PC_Add_temp),
    .RData(w_Read_Data),
    .WriteEnable(w_MemWrite),
    .ReadEnable(w_MemRead)
    );
    // 8.> Instantiate of Write Back MUX 
    Write_Back_Mux M1(
    .ip_alu_result(w_alu_output),
    .ip_Read_Data(w_Read_Data),
    .sel_MemtoReg(w_sel_MemtoReg),
    .op_Writeback_mux(op_WriteBack),
    .op_PC(w_PC_Add_temp)
    );
    // 9.> Instantiate the Instruction File
    inst_memory IM(
    .clk(clk),
    .reset(reset),
    .Address(w_PC_Add),
    .instruction(Instruction)
    );
    // 10.> Instantiate the PC
    Add_PC PC(
   .ip_add(w_Muc_PC),      
//   .ip_4bit(4'h4),  
   .ip_rst(reset),   
   .ip_clk(clk), 
   .op_add(w_PC_Add_temp),
   .pc_temp(pc_temp)
    );
    // 11.> Instantiate PC Mux Output
    Mux_PC M2(
    .ip_Add_PC(w_PC_Add_temp),     
    .ip_Add_J(op_ADD_J),       
    .sel_PCSrc(w_op_Branch_Unit),             
    .op_Mux_pc(w_Muc_PC) 
    );
    // 12.> Instantiate Adder Jump
    Add_J Add(
    .ip_Add_PC(pc_temp),
    .ip_Shift(w_imm),
    .op_Add(op_ADD_J)
    ); 
    // 13.> Instaniate Branch Unit
    Branch_Unit BU(
    .Instruction(Instruction),
    .ip_read_data1(w_Data_out1),
    .ip_read_data2(w_Data_out2),
    .Branch_En(w_Branch_En),
    .op_Branch_Unit(w_op_Branch_Unit)
    );
    // 14.> Instantiate the Shift Left Module
//    Shift_Op SL(
//    .Immediate(w_imm),
//    .op_shift_left(w_op_shift_left)
//    );
    //15 pc mux
    Pc_mux pc_sel_mux (           
   .pc(w_PC_Add_temp),           
   .mux_out(w_Muc_PC),     
   .br_en  (w_Branch_En || (w_Jump)),             
   .pc_out (w_PC_Add)  
    );                   
    
    
    
    
    
    
       
endmodule
