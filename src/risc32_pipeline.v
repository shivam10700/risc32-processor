module risc32_pipeline (
    input clk,
    input reset
);

    // Program Counter
    reg [31:0] PC;

    // Instruction Memory
    wire [31:0] instruction;

    instr_mem imem (
        .addr(PC),
        .instr(instruction)
    );

    // IF/ID Pipeline Register
    reg [31:0] IF_ID_instr, IF_ID_PC;

    // ID Stage Wires
    wire [4:0] rs1, rs2, rd;
    wire [31:0] reg_data1, reg_data2;
    wire [31:0] imm;

    assign rs1 = IF_ID_instr[19:15];
    assign rs2 = IF_ID_instr[24:20];
    assign rd  = IF_ID_instr[11:7];

    reg_file rf (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(WB_rd),
        .write_data(WB_data),
        .reg_write(WB_regwrite),
        .data1(reg_data1),
        .data2(reg_data2)
    );

    // Control Unit
    wire reg_write, mem_read, mem_write, alu_src;
    wire [2:0] alu_op;

    control_unit cu (
        .opcode(IF_ID_instr[6:0]),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .alu_op(alu_op)
    );

    // ID/EX Pipeline Register
    reg [31:0] ID_EX_A, ID_EX_B, ID_EX_imm;
    reg [4:0] ID_EX_rd;
    reg ID_EX_regwrite, ID_EX_memread, ID_EX_memwrite, ID_EX_alusrc;
    reg [2:0] ID_EX_aluop;

    // EX Stage
    wire [31:0] alu_in2 = ID_EX_alusrc ? ID_EX_imm : ID_EX_B;
    wire [31:0] alu_result;

    alu alu_unit (
        .a(ID_EX_A),
        .b(alu_in2),
        .alu_op(ID_EX_aluop),
        .result(alu_result)
    );

    // EX/MEM Pipeline Register
    reg [31:0] EX_MEM_result, EX_MEM_B;
    reg [4:0] EX_MEM_rd;
    reg EX_MEM_regwrite, EX_MEM_memread, EX_MEM_memwrite;

    // Data Memory
    wire [31:0] mem_data;

    data_mem dmem (
        .clk(clk),
        .addr(EX_MEM_result),
        .write_data(EX_MEM_B),
        .mem_read(EX_MEM_memread),
        .mem_write(EX_MEM_memwrite),
        .read_data(mem_data)
    );

    // MEM/WB Pipeline Register
    reg [31:0] MEM_WB_data;
    reg [4:0] MEM_WB_rd;
    reg MEM_WB_regwrite;

    // WB Stage
    wire [31:0] WB_data = MEM_WB_data;
    wire [4:0] WB_rd = MEM_WB_rd;
    wire WB_regwrite = MEM_WB_regwrite;

    // ================= Pipeline Updates =================

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 0;
        end else begin
            PC <= PC + 4;

            // IF/ID
            IF_ID_instr <= instruction;
            IF_ID_PC <= PC;

            // ID/EX
            ID_EX_A <= reg_data1;
            ID_EX_B <= reg_data2;
            ID_EX_imm <= IF_ID_instr[31:20];
            ID_EX_rd <= rd;
            ID_EX_regwrite <= reg_write;
            ID_EX_memread <= mem_read;
            ID_EX_memwrite <= mem_write;
            ID_EX_alusrc <= alu_src;
            ID_EX_aluop <= alu_op;

            // EX/MEM
            EX_MEM_result <= alu_result;
            EX_MEM_B <= ID_EX_B;
            EX_MEM_rd <= ID_EX_rd;
            EX_MEM_regwrite <= ID_EX_regwrite;
            EX_MEM_memread <= ID_EX_memread;
            EX_MEM_memwrite <= ID_EX_memwrite;

            // MEM/WB
            MEM_WB_data <= EX_MEM_memread ? mem_data : EX_MEM_result;
            MEM_WB_rd <= EX_MEM_rd;
            MEM_WB_regwrite <= EX_MEM_regwrite;
        end
    end

endmodule
