module microc(output wire [5:0] Opcode, output wire z, input wire clk, reset, s_inc, s_inm, we3, wez, input wire [2:0] Op);
//Microcontrolador sin memoria de datos de un solo ciclo

//Instanciar e interconectar pc, memprog, regfile, alu, sum, biestable Z y mux's
// Señales internas
wire[15:0] instruccion;
wire[9:0] pc, pc_next, pc_mux_out;
wire[7:0] wd3, rd1, rd2, alu_out;
wire z_alu;

// Opcode de salida
assign Opcode = instruccion[15:10];

// assign ra2[3:0] = instruccion[7:4];
// assign wa3[3:0] = instruccion[3:0];
// assign inm[7:0] = instruccion[11:4];
// assign dir_salto[9:0] = instruccion[9:0];

// Sumador: PC + 1
sum sumPC(pc_next, pc, 10'b1);

// MUX -> PC
mux2 #(10) muxPC(pc_mux_out, instruccion[9:0], pc_next, s_inc);

// PC
registro #(10) programCounter(pc, clk, reset, pc_mux_out);

// Memoria de programa
memprog memProg(instruccion, clk, pc);


// MUX output -> banco de registros
mux2 #(8) muxBancoReg(wd3, alu_out, instruccion[11:4], s_inc);

// Banco de registros
regfile bancoRegistros(rd1, rd2, clk, we3, instruccion[11:8],
                                          instruccion[7:4],
                                          instruccion[3:0],
                                          wd3);
// ALU
alu alu1(alu_out, z_alu, rd1, rd2, Op);

// Flip flop
ffd ffz(clk, reset, z_alu, wez, z);

endmodule
