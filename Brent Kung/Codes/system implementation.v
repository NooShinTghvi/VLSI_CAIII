module propagate_generate (
        input [15:0] a,
        input [15:0] b,
        output [15:0] p_0,
        output [15:0] g_0
    );

    genvar i;
	generate
		for (i = 0 ; i <= 15 ; i=i+1) begin
			xor (p_0[i],a[i],b[i]);
			and (g_0[i],a[i],b[i]);
		end	
	endgenerate

endmodule

module blackCell ( // Group propagate and generate
        input   i_pj,
        input   i_gj, 
        input   i_pk,
        input   i_gk,
        output  o_g,
        output  o_p
    );

    assign o_g = i_gk | (i_gj & i_pk);
    assign o_p = i_pk & i_pj;

endmodule

module greyCell( // Group generation
        input   i_gj, 
        input   i_pk,
        input   i_gk,
        output  o_g
    );

    assign o_g = i_gk | (i_gj & i_pk);

endmodule

module producePG( // generate propagate and generate 
        input   [15:0] a,
        input   [15:0] b,
        output  [15:0] p_0,
        output  [15:0] g_0
    );

    genvar i;
	generate
		for (i = 0 ; i <= 15 ; i=i+1) begin
			propagate_generate a (a[0], b[0], p_0[0], g_0[0]);
		end	
	endgenerate

endmodule

module myAssign (
    input a,
    output b
    );
    assign b = a;
endmodule

module level1(
        input   [15:0] p_0,
        input   [15:0] g_0,
        output  [15:0] p_1,
        output  [15:0] g_1
    );

    genvar i;
	generate
		for (i = 0 ; i <= 14 ; i=i+2) begin
			myAssign a (p_0[i],p_1[i]);
            myAssign b (g_0[i],g_1[i]);
		end	
	endgenerate

    greyCell gc_0(g_0[0], p_0[1], g_0[1], g_1[1]);
    assign p_1[1] = 1'bx;

    genvar j;
	generate
		for (j = 3 ; j <= 15 ; j=j+2) begin
			blackCell a (p_0[j], g_0[j], p_0[j], g_0[j], g_1[j], p_1[j]);
		end	
	endgenerate
endmodule

module level2(
        input   [15:0] p_1,
        input   [15:0] g_1,
        output  [15:0] p_2,
        output  [15:0] g_2
    );

    genvar i;
	generate
		for (i = 0 ; i <= 14 ; i=i+2) begin
			myAssign a (p_1[i],p_2[i]);
            myAssign b (g_1[i],g_2[i]);
		end	
	endgenerate

    genvar j;
	generate
		for (j = 1 ; j <= 13 ; j=j+4) begin
            myAssign c (p_1[j],p_2[j]);
            myAssign d (g_1[j],g_2[j]);
		end	
	endgenerate

    greyCell e (g_1[1], p_1[3], g_1[3], g_2[3]);
    assign p_2[3] = 1'bx;

    genvar k;
	generate
		for (k = 7 ; k <= 15 ; k=k+4) begin
			blackCell f (p_1[k-2], g_1[k-2], p_1[k], g_1[k], g_2[k], p_2[k]);
		end	
	endgenerate
    
endmodule

module level3(
        input   [15:0] p_2,
        input   [15:0] g_2,
        output  [15:0] p_3,
        output  [15:0] g_3
    );

    genvar i;
	generate
		for (i = 0 ; i <= 6 ; i=i+1) begin
			myAssign a (p_2[i],p_3[i]);
            myAssign b (g_2[i],g_3[i]);
		end	
	endgenerate

    genvar j;
	generate
		for (j = 8 ; j <= 14 ; j=j+1) begin
            myAssign c (p_2[j],p_3[j]);
            myAssign d (g_2[j],g_3[j]);
		end	
	endgenerate

    greyCell e (g_2[3], p_2[7], g_2[7], g_3[7]);
    assign p_3[7] = 1'bx;

    blackCell f (p_2[11], g_2[11], p_2[15], g_2[15], g_3[15], p_3[15]);
endmodule

module level4(
        input   [15:0] p_3,
        input   [15:0] g_3,
        output  [15:0] p_4,
        output  [15:0] g_4
    );

    genvar i;
	generate
		for (i = 0 ; i <= 14 ; i=i+1) begin
			myAssign a (p_3[i],p_4[i]);
            myAssign b (g_3[i],g_4[i]);
		end	
	endgenerate

    greyCell e (g_3[7], p_3[15], g_3[15], g_4[15]);
    assign p_4[15] = 1'bx;
endmodule

module level5(
        input   [15:0] p_4,
        input   [15:0] g_4,
        output  [15:0] p_5,
        output  [15:0] g_5
    );

    genvar i;
	generate
		for (i = 0 ; i <= 10 ; i=i+1) begin
			myAssign a (p_4[i],p_5[i]);
            myAssign b (g_4[i],g_5[i]);
		end	
	endgenerate

    genvar j;
	generate
		for (j = 12 ; j <= 15 ; j=j+1) begin
            myAssign c (p_4[j],p_5[j]);
            myAssign d (g_4[j],g_5[j]);
		end	
	endgenerate

    greyCell e (g_4[7], p_4[11], g_4[11], g_5[11]);
    assign p_5[11] = 1'bx;
endmodule

module level6(
        input   [15:0] p_5,
        input   [15:0] g_5,
        output  [15:0] p_6,
        output  [15:0] g_6
    );

    genvar i;
	generate
		for (i = 0 ; i <= 14 ; i=i+2) begin
			myAssign a (p_5[i],p_6[i]);
            myAssign b (g_5[i],g_6[i]);
		end	
	endgenerate

    genvar k;
	generate
		for (k = 5 ; k <= 13 ; k=k+4) begin
			greyCell c (g_5[k], p_5[k], g_5[k], g_6[k]);
            /*myAssign d (p_6[k], 1'bx);*/
		end	
	endgenerate
    
    genvar j;
	generate
		for (j = 3 ; j <= 15 ; j=j+4) begin
            myAssign e (p_5[j],p_6[j]);
            myAssign f (g_5[j],g_6[j]);
		end	
	endgenerate

    assign p_6[1] = p_5[1];
    assign g_6[1] = g_5[1];
endmodule

module level7(
        input   [15:0] p_6,
        input   [15:0] g_6,
        output  [15:0] p_7,
        output  [15:0] g_7
    );

    genvar i;
	generate
		for (i = 1 ; i <= 15 ; i=i+2) begin
			myAssign a (p_6[i],p_7[i]);
            myAssign b (g_6[i],g_7[i]);
		end	
	endgenerate

    genvar k;
	generate
		for (k = 2 ; k <= 14 ; k=k+2) begin
			greyCell c (g_6[k], p_6[k], g_6[k], g_7[k]);
            /*myAssign d (p_7[k], 1'bx);*/
		end	
	endgenerate

    assign p_7[0] = p_6[0];
    assign g_7[0] = g_6[0];
endmodule

module sumLogic(
    input [15:0] p_0,
    input [15:0] g_7,
    output [15:0] s
    );
    genvar i;
	generate
		for (i = 0 ; i <= 15 ; i=i+1) begin
			xor (s[i],p_0[i],g_7[i]);
		end	
	endgenerate
endmodule

module Brent_Kung(
        input  [15:0] a,
        input  [15:0] b,
        output [15:0] s,
        output        carry
    );

    wire [15:0] p_0,g_0,p_1,g_1,p_2,g_2,p_3,g_3,p_4,g_4,p_5,g_5,p_6,g_6,p_7,g_7;
    propagate_generate s1(a,b,p_0,g_0);
    level1 s2(p_0,g_0,p_1,g_1);
    level2 s3(p_1,g_1,p_2,g_2);
    level3 s4(p_2,g_2,p_3,g_3);
    level4 s5(p_3,g_3,p_4,g_4);
    level5 s6(p_4,g_4,p_5,g_5);
    level6 s7(p_5,g_5,p_6,g_6);
    level7 s8(p_6,g_6,p_7,g_7);
    sumLogic s9(p_0,g_7,s);
    assign carry = (g_0[15] | (g_7[15] & p_0[15]));
endmodule