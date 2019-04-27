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

    propagate_generate a0(a[0], b[0], p_0[0], g_0[0]);
    propagate_generate a1(a[1], b[1], p_0[1], g_0[1]);
    propagate_generate a2(a[2], b[2], p_0[2], g_0[2]);
    propagate_generate a3(a[3], b[3], p_0[3], g_0[3]);
    propagate_generate a4(a[4], b[4], p_0[4], g_0[4]);
    propagate_generate a5(a[5], b[5], p_0[5], g_0[5]);
    propagate_generate a6(a[6], b[6], p_0[6], g_0[6]);
    propagate_generate a7(a[7], b[7], p_0[7], g_0[7]);
    propagate_generate a8(a[8], b[8], p_0[8], g_0[8]);
    propagate_generate a9(a[9], b[9], p_0[9], g_0[9]);
    propagate_generate a10(a[10], b[10], p_0[10], g_0[10]);
    propagate_generate a11(a[11], b[11], p_0[11], g_0[11]);
    propagate_generate a12(a[12], b[12], p_0[12], g_0[12]);
    propagate_generate a13(a[13], b[13], p_0[13], g_0[13]);
    propagate_generate a14(a[14], b[14], p_0[14], g_0[14]);
    propagate_generate a15(a[15], b[15], p_0[15], g_0[15]);

endmodule

module level1(
        input   [15:0] p_0,
        input   [15:0] g_0,
        output  [15:0] p_1,
        output  [15:0] g_1
    );

    assign p_1[0] = p_0[0];
    assign g_1[0] = g_0[0];
    
    greyCell gc_0(g_0[0], p_0[1], g_0[1], g_1[1]);
    assign p_1[1] = 1'bx;
    blackCell bc_0(p_0[1], g_0[1], p_0[2], g_0[2], g_1[2], p_1[2]);
    blackCell bc_1(p_0[2], g_0[2], p_0[3], g_0[3], g_1[3], p_1[3]);
    blackCell bc_2(p_0[3], g_0[3], p_0[4], g_0[4], g_1[4], p_1[4]);
    blackCell bc_3(p_0[4], g_0[4], p_0[5], g_0[5], g_1[5], p_1[5]);
    blackCell bc_4(p_0[5], g_0[5], p_0[6], g_0[6], g_1[6], p_1[6]);
    blackCell bc_5(p_0[6], g_0[6], p_0[7], g_0[7], g_1[7], p_1[7]);
    blackCell bc_6(p_0[7], g_0[7], p_0[8], g_0[8], g_1[8], p_1[8]);
    blackCell bc_7(p_0[8], g_0[8], p_0[9], g_0[9], g_1[9], p_1[9]);
    blackCell bc_8(p_0[9], g_0[9], p_0[10], g_0[10], g_1[10], p_1[10]);
    blackCell bc_9(p_0[10], g_0[10], p_0[11], g_0[11], g_1[11], p_1[11]);
    blackCell bc_10(p_0[11], g_0[11], p_0[12], g_0[12], g_1[12], p_1[12]);
    blackCell bc_11(p_0[12], g_0[12], p_0[13], g_0[13], g_1[13], p_1[13]);
    blackCell bc_12(p_0[13], g_0[13], p_0[14], g_0[14], g_1[14], p_1[14]);
    blackCell bc_13(p_0[14], g_0[14], p_0[15], g_0[15], g_1[15], p_1[15]);

endmodule

module level2(
        input   [15:0] p_1,
        input   [15:0] g_1,
        output  [15:0] p_2,
        output  [15:0] g_2
    );

    assign p_2[0] = p_1[0];
    assign g_2[0] = g_1[0];
    assign p_2[1] = p_1[1];
    assign g_2[1] = g_1[1];

    greyCell gc_0(g_1[1], p_1[2], g_1[2], g_2[2]);
    assign p_2[2] = 1'bx;
    greyCell gc_1(g_1[2], p_1[3], g_1[3], g_2[3]);
    assign p_2[3] = 1'bx;
    blackCell bc_0(p_1[3], g_1[3], p_1[4], g_1[4], g_2[4], p_2[4]);
    blackCell bc_1(p_1[4], g_1[4], p_1[5], g_1[5], g_2[5], p_2[5]);
    blackCell bc_2(p_1[5], g_1[5], p_1[6], g_1[6], g_2[6], p_2[6]);
    blackCell bc_3(p_1[6], g_1[6], p_1[7], g_1[7], g_2[7], p_2[7]);
    blackCell bc_4(p_1[7], g_1[7], p_1[8], g_1[8], g_2[8], p_2[8]);
    blackCell bc_5(p_1[8], g_1[8], p_1[9], g_1[9], g_2[9], p_2[9]);
    blackCell bc_6(p_1[9], g_1[9], p_1[10], g_1[10], g_2[10], p_2[10]);
    blackCell bc_7(p_1[10], g_1[10], p_1[11], g_1[11], g_2[11], p_2[11]);
    blackCell bc_8(p_1[11], g_1[11], p_1[12], g_1[12], g_2[12], p_2[12]);
    blackCell bc_9(p_1[12], g_1[12], p_1[13], g_1[13], g_2[13], p_2[13]);
    blackCell bc_10(p_1[13], g_1[13], p_1[14], g_1[14], g_2[14], p_2[14]);
    blackCell bc_11(p_1[14], g_1[14], p_1[15], g_1[15], g_2[15], p_2[15]);

endmodule

module level3(
        input   [15:0] p_2,
        input   [15:0] g_2,
        output  [15:0] p_3,
        output  [15:0] g_3
    );

    assign p_3[0] = p_2[0];
    assign g_3[0] = g_2[0];
    assign p_3[1] = p_2[1];
    assign g_3[1] = g_2[1];
    assign p_3[2] = p_2[2];
    assign g_3[2] = g_2[2];
    assign p_3[3] = p_2[3];
    assign g_3[3] = g_2[3];

    greyCell gc_0(g_2[0], p_2[4], g_2[4], g_3[4]);
    assign p_3[4] = 1'bx;
    greyCell gc_1(g_2[1], p_2[5], g_2[5], g_3[5]);
    assign p_3[5] = 1'bx;
    greyCell gc_2(g_2[2], p_2[6], g_2[6], g_3[6]);
    assign p_3[6] = 1'bx;
    greyCell gc_3(g_2[3], p_2[7], g_2[7], g_3[7]);
    assign p_3[7] = 1'bx;
    blackCell bc_0(p_2[4], g_2[4], p_2[8], g_2[8], g_3[8], p_3[8]);
    blackCell bc_1(p_2[5], g_2[5], p_2[9], g_2[9], g_3[9], p_3[9]);
    blackCell bc_2(p_2[6], g_2[6], p_2[10], g_2[10], g_3[10], p_3[10]);
    blackCell bc_3(p_2[7], g_2[7], p_2[11], g_2[11], g_3[11], p_3[11]);
    blackCell bc_4(p_2[8], g_2[8], p_2[12], g_2[12], g_3[12], p_3[12]);
    blackCell bc_5(p_2[9], g_2[9], p_2[13], g_2[13], g_3[13], p_3[13]);
    blackCell bc_6(p_2[10], g_2[10], p_2[14], g_2[14], g_3[14], p_3[14]);
    blackCell bc_7(p_2[11], g_2[11], p_2[15], g_2[15], g_3[15], p_3[15]);
endmodule

module level4(
        input   [15:0] p_3,
        input   [15:0] g_3,
        output  [15:0] p_4,
        output  [15:0] g_4
    );

    assign p_4[0] = p_3[0];
    assign g_4[0] = g_3[0];
    assign p_4[1] = p_3[1];
    assign g_4[1] = g_3[1];
    assign p_4[2] = p_3[2];
    assign g_4[2] = g_3[2];
    assign p_4[3] = p_3[3];
    assign g_4[3] = g_3[3];
    assign p_4[4] = p_3[4];
    assign g_4[4] = g_3[4];
    assign p_4[5] = p_3[5];
    assign g_4[5] = g_3[5];
    assign p_4[6] = p_3[6];
    assign g_4[6] = g_3[6];
    assign p_4[7] = p_3[7];
    assign g_4[7] = g_3[7];

    greyCell gc_0(g_3[0], p_3[8], g_3[8], g_4[8]);
    assign p_4[8] = 1'bx;
    greyCell gc_1(g_3[1], p_3[9], g_3[9], g_4[9]);
    assign p_4[9] = 1'bx;
    greyCell gc_2(g_3[2], p_3[10], g_3[10], g_4[10]);
    assign p_4[10] = 1'bx;
    greyCell gc_3(g_3[3], p_3[11], g_3[11], g_4[11]);
    assign p_4[11] = 1'bx;
    greyCell gc_4(g_3[4], p_3[12], g_3[12], g_4[12]);
    assign p_4[12] = 1'bx;
    greyCell gc_5(g_3[5], p_3[13], g_3[13], g_4[13]);
    assign p_4[13] = 1'bx;
    greyCell gc_6(g_3[6], p_3[14], g_3[14], g_4[14]);
    assign p_4[14] = 1'bx;
    greyCell gc_7(g_3[7], p_3[15], g_3[15], g_4[15]);
    assign p_4[15] = 1'bx;
endmodule

module sumLogic(
    input [15:0] p_0,
    input [15:0] g_4,
    output [15:0] s
    );
    assign s[0] = p_0[0] ^ g_4[0];
    assign s[1] = p_0[1] ^ g_4[1];
    assign s[2] = p_0[2] ^ g_4[2];
    assign s[3] = p_0[3] ^ g_4[3];
    assign s[4] = p_0[4] ^ g_4[4];
    assign s[5] = p_0[5] ^ g_4[5];
    assign s[6] = p_0[6] ^ g_4[6];
    assign s[7] = p_0[7] ^ g_4[7];
    assign s[8] = p_0[8] ^ g_4[8];
    assign s[9] = p_0[9] ^ g_4[9];
    assign s[10] = p_0[10] ^ g_4[10];
    assign s[11] = p_0[11] ^ g_4[11];
    assign s[12] = p_0[12] ^ g_4[12];
    assign s[13] = p_0[13] ^ g_4[13];
    assign s[14] = p_0[14] ^ g_4[14];
    assign s[15] = p_0[15] ^ g_4[15];
endmodule

module Kogge_Stone(
        input  [15:0] a,
        input  [15:0] b,
        output [15:0] s,
        output        carry
    );

    wire [15:0] p_0,g_0,p_1,g_1,p_2,g_2,p_3,g_3,p_4,g_4;
    propagate_generate s1(a,b,p_0,g_0);
    level1 s2(p_0,g_0,p_1,g_1);
    level2 s3(p_1,g_1,p_2,g_2);
    level3 s4(p_2,g_2,p_3,g_3);
    level4 s5(p_3,g_3,p_4,g_4);
    sumLogic s6(p_0,g_4,s);
    assign carry = (g_0[15] | (g_4[15] & p_0[15]));
endmodule