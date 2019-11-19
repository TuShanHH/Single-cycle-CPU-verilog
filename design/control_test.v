module mainCtl_test();
    reg [5:0] OP;
    wire jump,extop,branch;
    wire memWrite,memToReg,ALUsrc;
    wire regWrite,regDst;
    wire [2:0] ALUop;

    initial OP=6'b000000;

    always #10
    begin
        if (OP==6'b000000) OP=6'b001101;
        else if (OP==6'b001101) OP=6'b100011;
        else if (OP==6'b100011) OP=6'b101011;
        else if (OP==6'b101011) OP=6'b000100;
        else if (OP==6'b000100) OP=6'b000010;
        else if (OP==6'b000010) OP=6'b000000;
    end

    main_control _main(.OP(OP),.jump(jump),.extop(extop),
                .branch(branch),.memWrite(memWrite),
                .memToReg(memToReg),.ALUsrc(ALUsrc),
                .regWrite(regWrite),.regDst(regDst),
                .ALUop(ALUop));


endmodule //主控电路测试

module ALUctl_test();
    reg [2:0] ALUop;
    reg [5:0] funct;
    wire [2:0] ALUctr;

    initial
    begin
        ALUop=3'b000;
        funct=4'b0000;
    end

    always #10
    begin
        if (ALUop==3'b000) ALUop=3'b010;
        else if (ALUop==3'b010) ALUop=3'b001;
        else if (ALUop==3'b001) ALUop=3'b011;
        else if (ALUop==3'b011) ALUop=3'b100;
        else if (ALUop==3'b100)
        begin
            if (funct==4'b0000) funct=4'b0010;
            else if (funct==4'b0010) funct=4'b0100;
            else if (funct==4'b0100) funct=4'b0101;
            else if (funct==4'b0101) funct=4'b1010;
            else if (funct==4'b1010)
            begin
                funct=4'b0000;
                ALUop=3'b000;
            end
        end
    end

    ALU_control _ALU(.ALUop(ALUop),.funct(funct),.ALUctr(ALUctr));

endmodule // ALU控制测试