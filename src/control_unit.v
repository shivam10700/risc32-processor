module control_unit (
    input [6:0] opcode,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg [2:0] alu_op
);

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type
                reg_write = 1;
                mem_read = 0;
                mem_write = 0;
                alu_src = 0;
                alu_op = 3'b000;
            end

            7'b0000011: begin // Load
                reg_write = 1;
                mem_read = 1;
                mem_write = 0;
                alu_src = 1;
                alu_op = 3'b000;
            end

            7'b0100011: begin // Store
                reg_write = 0;
                mem_read = 0;
                mem_write = 1;
                alu_src = 1;
                alu_op = 3'b000;
            end

            default: begin
                reg_write = 0;
                mem_read = 0;
                mem_write = 0;
                alu_src = 0;
                alu_op = 3'b000;
            end
        endcase
    end

endmodule
