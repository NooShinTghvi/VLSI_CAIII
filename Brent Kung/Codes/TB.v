
`timescale 1ns / 1ps
module ATB();      
    reg     [15:0]  a, b;   
    wire    [15:0]  s;       
    wire            carry;     
    reg     [32:0]  check;   
    integer         i, j;    
    integer         num_correct; 
    integer         num_wrong;  

    Brent_Kung bs(a, b, s, carry);

    initial begin
        $display("Running testbench, this may take a minute or two...");
        // initialize the counter variables
        num_correct = 0; num_wrong = 0;
        // Produce some tests and check with their corresponding results.
        for (i = 0; i < 2500; i = i + 1) begin
            a = i;
            for (j = 0; j < 2500; j = j + 1) begin
                b = j;
                #10;
                check = a + b;
                // compute and check the product
                if ({carry, s} == check) begin
                    num_correct = num_correct + 1;
                end 
                else begin
                    num_wrong = num_wrong + 1;
                end

                // following line is for debugging
                //$display($time, " %d + %d = %d (%d)", a, b, {carry, s}, check);
            end
        end
        
        // print the final counter values
        //$display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);
        $stop;
        
        /*a = 16'd75
        b = 16'd50;
        #100
        $stop;*/
    end
endmodule