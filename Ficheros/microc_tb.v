`timescale 1 ns / 10 ps
module microc_tb;

// declaración de variables
reg clk, reset, s_inc, s_inm, we3, wez;
reg [2:0] op;
wire z;
wire [5:0] opcode;

// instanciación del camino de datos
microc microc(opcode, z, clk, reset, s_inc, s_inm, we3, wez, op);

// generación de reloj clk
always
  begin
    clk=1;
    #20;
    clk=0;
    #20;
  end

// Reseteo y configuración de salidas del testbench
// Bloque simulación señales control por ciclo
initial
  begin
    $dumpfile("microc_tb.vcd");
    $dumpvars(0, microc_tb);
    // ... señal de reset
    // retardos y señales para ejecutar primera instrucción (ciclo 1)

    // Inicialización de señales
    clk = 1;
    s_inc = 0;
    s_inm = 0;
    we3 = 0;
    wez = 0;
    op = 3'b000;

    // Reseteo
    reset=1;
    #10
    reset=0;
    #10

    // Ciclo 0: j Start
    we3=0;
    wez=0;
    s_inc=0;
    s_inm=0;
    op=3'b000;

    // Ciclos 1-4 (nop)

    // Ciclo 5: li 0, R2
    #40
    we3=1;
    wez=0;
    s_inc=1;
    s_inm=1;
    op=3'b000;

    // Ciclo 6: li 2, R1
    #40
    we3=1;
    s_inc=1;
    s_inm=1;
    op=3'b000;

    // Ciclo 7: li 4, R3
    #40
    we3=1;
    s_inc=1;
    s_inm=1;
    op=3'b000;

    // Ciclo 8: li 1, R4
    #40
    we3=1;
    s_inc=1;
    s_inm=1;
    op=3'b000;

    // Bucle for (Iteracion 1)
    // Ciclo 9: add R2 R3 R2
    #40
    we3=1;
    wez=1;
    s_inc=1;
    s_inm=0;
    op=3'b010;

    // Ciclo 10: sub R1 R4 R1
    #40
    we3=1;
    wez=1;
    s_inc=1;
    s_inm=0;
    op=3'b011;

    // Ciclo 11: jnz Iter
    #40
    we3=0;
    wez=0;
    s_inc=0;
    s_inm=0;
    op=3'b000;


    // Bucle for (Iteracion 2)
    // Ciclo 12: add R2 R3 R2
    #40
    we3=1;
    wez=1;
    s_inc=1;
    s_inm=0;
    op=3'b010;

    // Ciclo 13: sub R1 R4 R1
    #40
    we3=1;
    wez=1;
    s_inc=1;
    s_inm=0;
    op=3'b011;

    // Ciclo 14: jnz Iter (no salta al principio del bucle)
    #40
    we3=0;
    wez=0;
    s_inc=1;
    s_inm=0;
    op=3'b000;

    // Ciclo 15: j Fin
    #40
    we3=0;
    wez=1;
    s_inc=0;
    s_inm=0;

    #300

  $finish;
end
endmodule
