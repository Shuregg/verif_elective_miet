module testbench;

    // Тактовый сигнал и сигнал сброса
    logic clk;
    logic aresetn;

    // Остальные сигналы
    logic [7:0] A;
    logic [7:0] B;
    logic [7:0] C;

    sum DUT(
        .clk     ( clk     ),
        .aresetn ( aresetn ),
        .a       ( A       ),
        .b       ( B       ),
        .c       ( C       )
    );

    // Период тактового сигнала
    parameter CLK_PERIOD = 10;

    // Генерация тактового сигнала
    initial begin
        clk <= 0;
        forever begin
            #(CLK_PERIOD/2) clk <= ~clk;
        end
    end

    // Генерация сигнала сброса
    initial begin
        aresetn <= 0;
        #(CLK_PERIOD);
        aresetn <= 1;
    end

    // Генерация входных сигналов
    initial begin
        wait(aresetn);
        for(int i = 0; i < 6; i = i + 1) begin
            @(posedge clk);
            A <= i;
            B <= i + 1;
        end
    end

    // Проверка выходных сигналов
    initial begin
        wait(aresetn);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        if( C !== 1 ) $error("BAD");
        @(posedge clk);
        if( C !== 3 ) $error("BAD");
        @(posedge clk);
        if( C !== 5 ) $error("BAD");
        @(posedge clk);
        if( C !== 7 ) $error("BAD");
        @(posedge clk);
        if( C !== 9 ) $error("BAD");
        @(posedge clk);
        if( C !== 11 ) $error("BAD");
        $stop();
    end

endmodule
