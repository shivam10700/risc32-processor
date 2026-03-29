module reg_file (
    input clk,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_data,
    input reg_write,
    output [31:0] data1, data2
);

    reg [31:0] registers [31:0];

    assign data1 = registers[rs1];
    assign data2 = registers[rs2];
  
  integer i;
initial begin
    for (i = 0; i < 32; i = i + 1)
        registers[i] = i;  // simple known values
end

    always @(posedge clk) begin
        if (reg_write && rd != 0)
            registers[rd] <= write_data;
    end

endmodule
