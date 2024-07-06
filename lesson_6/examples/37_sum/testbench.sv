module testbench;

    // Тактовый сигнал и сигнал сброса
    logic clk;
    logic aresetn;

    // Остальные сигналы
    logic [7:0] a;
    logic [7:0] b;
    logic [7:0] c;

    sum DUT(
        .clk     ( clk     ),
        .aresetn ( aresetn ),
        .a       ( a       ),
        .b       ( b       ),
        .c       ( c       )
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
        @(posedge clk);
        a <= 8'h1;
        b <= 8'h1;
        @(posedge clk);
        a <= 8'h3;
        b <= 8'h2;
        @(posedge clk);
        a <= 8'h4;
        @(posedge clk);
        $finish();
    end

    // Покрытие
    covergroup sum_cg @(posedge clk);
        a_cp: coverpoint a {
            bins b1 [5] = {[1:5]};
        }
        b_cp: coverpoint b {
            bins b1 [5] = {[1:5]};
        }
    endgroup

    covergroup sum_cg_2 @(posedge clk);
        a_cp: coverpoint a;
    endgroup

    sum_cg_2 cg_2;
    sum_cg_2 cg_3;

    initial begin
        cg_2 = new();
        cg_3 = new();
    end

endmodule
