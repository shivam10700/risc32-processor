module instr_mem (
    input [31:0] addr,
    output [31:0] instr
);

    reg [31:0] memory [0:255];

    initial begin
        memory[0] = 32'h002081b3; // add x3,x1,x2
    memory[1] = 32'h00310233; // add x4,x2,x3
    memory[2] = 32'h004183b3;
    memory[3] = 32'h00520433;
    memory[4] = 32'h006284b3;
    end

    assign instr = memory[addr[9:2]];

endmodule
