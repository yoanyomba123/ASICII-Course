/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : M-2016.12-SP1
// Date      : Wed Jan 30 09:48:09 2019
/////////////////////////////////////////////////////////////


module dff_0 ( clk, q, d );
  input clk, d;
  output q;


  DFFX1_RVT q_reg ( .D(d), .CLK(clk), .Q(q) );
endmodule


module dff_1 ( clk, q, d );
  input clk, d;
  output q;


  DFFX1_RVT q_reg ( .D(d), .CLK(clk), .Q(q) );
endmodule


module dff_2 ( clk, q, d );
  input clk, d;
  output q;


  DFFX1_RVT q_reg ( .D(d), .CLK(clk), .Q(q) );
endmodule


module dff_3 ( clk, q, d );
  input clk, d;
  output q;


  DFFX1_RVT q_reg ( .D(d), .CLK(clk), .Q(q) );
endmodule


module dff_4 ( clk, q, d );
  input clk, d;
  output q;


  DFFX1_RVT q_reg ( .D(d), .CLK(clk), .Q(q) );
endmodule


module dff_5 ( clk, q, d );
  input clk, d;
  output q;


  DFFX1_RVT q_reg ( .D(d), .CLK(clk), .Q(q) );
endmodule


module s386 ( GND, VDD, CK, v0, v1, v13_D_10, v13_D_11, v13_D_12, v13_D_6, 
        v13_D_7, v13_D_8, v13_D_9, v2, v3, v4, v5, v6 );
  input GND, VDD, CK, v0, v1, v2, v3, v4, v5, v6;
  output v13_D_10, v13_D_11, v13_D_12, v13_D_6, v13_D_7, v13_D_8, v13_D_9;
  wire   v12, v11, v10, v9, v8, v7, Lv13_D_12, Lv13_D_11, Lv13_D_10, Lv13_D_9,
         Lv13_D_8, Lv13_D_7, Lv13_D_6, Lv13_D_5, Lv13_D_4, Lv13_D_3, Lv13_D_2,
         Lv13_D_1, Lv13_D_0, n2, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71;
  assign v13_D_12 = Lv13_D_12;
  assign v13_D_11 = Lv13_D_11;
  assign v13_D_10 = Lv13_D_10;
  assign v13_D_9 = Lv13_D_9;
  assign v13_D_8 = Lv13_D_8;
  assign v13_D_7 = Lv13_D_7;
  assign v13_D_6 = Lv13_D_6;

  dff_0 DFF_0 ( .clk(CK), .q(v12), .d(Lv13_D_5) );
  dff_5 DFF_1 ( .clk(CK), .q(v11), .d(Lv13_D_4) );
  dff_4 DFF_2 ( .clk(CK), .q(v10), .d(Lv13_D_3) );
  dff_3 DFF_3 ( .clk(CK), .q(v9), .d(Lv13_D_2) );
  dff_2 DFF_4 ( .clk(CK), .q(v8), .d(Lv13_D_1) );
  dff_1 DFF_5 ( .clk(CK), .q(v7), .d(Lv13_D_0) );
  INVX1_RVT U74 ( .A(n62), .Y(n28) );
  AND2X1_RVT U75 ( .A1(n2), .A2(v11), .Y(n61) );
  AND2X1_RVT U76 ( .A1(n63), .A2(n61), .Y(n62) );
  INVX1_RVT U77 ( .A(v11), .Y(n7) );
  INVX1_RVT U78 ( .A(v12), .Y(n4) );
  NBUFFX2_RVT U79 ( .A(n23), .Y(n71) );
  AO21X1_RVT U80 ( .A1(n39), .A2(n40), .A3(n69), .Y(Lv13_D_3) );
  NAND3X0_RVT U81 ( .A1(v10), .A2(n17), .A3(v1), .Y(n43) );
  NAND3X0_RVT U82 ( .A1(n70), .A2(n39), .A3(v1), .Y(n45) );
  AND2X1_RVT U83 ( .A1(n63), .A2(n53), .Y(Lv13_D_1) );
  AO22X1_RVT U84 ( .A1(n71), .A2(n34), .A3(n64), .A4(n17), .Y(Lv13_D_4) );
  NBUFFX2_RVT U85 ( .A(n35), .Y(n63) );
  NOR3X0_RVT U86 ( .A1(v10), .A2(v9), .A3(n50), .Y(n35) );
  INVX1_RVT U87 ( .A(n28), .Y(n64) );
  INVX1_RVT U88 ( .A(v8), .Y(n65) );
  AND2X1_RVT U89 ( .A1(n7), .A2(n4), .Y(n66) );
  AND2X1_RVT U90 ( .A1(n51), .A2(n66), .Y(n39) );
  AND3X1_RVT U91 ( .A1(n10), .A2(v10), .A3(n70), .Y(n67) );
  NBUFFX2_RVT U92 ( .A(n14), .Y(n68) );
  AND3X1_RVT U93 ( .A1(n8), .A2(n12), .A3(n68), .Y(n22) );
  INVX0_RVT U94 ( .A(v1), .Y(n14) );
  NAND3X0_RVT U95 ( .A1(v8), .A2(n30), .A3(n71), .Y(n29) );
  NAND3X0_RVT U96 ( .A1(n44), .A2(n41), .A3(n45), .Y(Lv13_D_2) );
  NAND3X0_RVT U97 ( .A1(n13), .A2(n17), .A3(n46), .Y(n44) );
  AND2X1_RVT U98 ( .A1(n49), .A2(n8), .Y(n69) );
  NAND2X0_RVT U99 ( .A1(n39), .A2(n67), .Y(n18) );
  NOR2X1_RVT U100 ( .A1(v6), .A2(n18), .Y(Lv13_D_8) );
  INVX1_RVT U101 ( .A(n37), .Y(n6) );
  NAND2X0_RVT U102 ( .A1(n21), .A2(n16), .Y(n37) );
  AND2X1_RVT U103 ( .A1(n4), .A2(n10), .Y(n20) );
  INVX1_RVT U104 ( .A(n31), .Y(n5) );
  INVX1_RVT U105 ( .A(v7), .Y(n12) );
  NAND2X0_RVT U106 ( .A1(n19), .A2(n18), .Y(Lv13_D_9) );
  NAND4X0_RVT U107 ( .A1(n20), .A2(n21), .A3(v4), .A4(n22), .Y(n19) );
  INVX1_RVT U108 ( .A(n36), .Y(n2) );
  AND3X1_RVT U109 ( .A1(v1), .A2(n52), .A3(n46), .Y(Lv13_D_10) );
  AO21X1_RVT U110 ( .A1(v5), .A2(n70), .A3(n8), .Y(n52) );
  INVX1_RVT U111 ( .A(v4), .Y(n16) );
  AND2X1_RVT U112 ( .A1(v9), .A2(n39), .Y(n46) );
  NAND3X0_RVT U113 ( .A1(n18), .A2(n41), .A3(n47), .Y(Lv13_D_11) );
  NAND3X0_RVT U114 ( .A1(n48), .A2(n8), .A3(n20), .Y(n47) );
  AO21X1_RVT U115 ( .A1(n5), .A2(v8), .A3(n6), .Y(n48) );
  OA21X1_RVT U116 ( .A1(n68), .A2(v9), .A3(v0), .Y(n42) );
  OA21X1_RVT U117 ( .A1(n26), .A2(n27), .A3(n7), .Y(n25) );
  AND2X1_RVT U118 ( .A1(v7), .A2(v4), .Y(n27) );
  NAND2X0_RVT U119 ( .A1(v12), .A2(n51), .Y(n36) );
  AND4X1_RVT U120 ( .A1(n46), .A2(v5), .A3(v10), .A4(n13), .Y(Lv13_D_12) );
  INVX1_RVT U121 ( .A(v10), .Y(n8) );
  INVX1_RVT U122 ( .A(v5), .Y(n17) );
  INVX1_RVT U123 ( .A(v9), .Y(n10) );
  NAND2X0_RVT U124 ( .A1(n42), .A2(n43), .Y(n40) );
  OAI22X1_RVT U125 ( .A1(v11), .A2(n36), .A3(v12), .A4(n54), .Y(n53) );
  OA22X1_RVT U126 ( .A1(n55), .A2(n7), .A3(v11), .A4(n56), .Y(n54) );
  OA22X1_RVT U127 ( .A1(n15), .A2(n57), .A3(n58), .A4(n16), .Y(n56) );
  OA21X1_RVT U128 ( .A1(n60), .A2(n6), .A3(n71), .Y(Lv13_D_0) );
  OA21X1_RVT U129 ( .A1(n65), .A2(n12), .A3(v11), .Y(n60) );
  NAND2X0_RVT U130 ( .A1(n31), .A2(n32), .Y(n30) );
  OR3X2_RVT U131 ( .A1(n33), .A2(v11), .A3(n15), .Y(n32) );
  NAND3X0_RVT U132 ( .A1(n37), .A2(n12), .A3(n38), .Y(n34) );
  NAND3X0_RVT U133 ( .A1(n7), .A2(n65), .A3(v2), .Y(n38) );
  NAND2X0_RVT U134 ( .A1(v7), .A2(v11), .Y(n31) );
  NAND2X0_RVT U135 ( .A1(v2), .A2(n12), .Y(n33) );
  NAND2X0_RVT U136 ( .A1(v8), .A2(n33), .Y(n57) );
  AND2X1_RVT U137 ( .A1(n12), .A2(n11), .Y(n51) );
  OA22X1_RVT U138 ( .A1(v2), .A2(v7), .A3(v3), .A4(n11), .Y(n26) );
  AO21X1_RVT U139 ( .A1(n5), .A2(n11), .A3(n6), .Y(n24) );
  AOI21X1_RVT U140 ( .A1(n11), .A2(v2), .A3(v7), .Y(n58) );
  NAND2X0_RVT U141 ( .A1(v7), .A2(n65), .Y(n59) );
  OA22X1_RVT U142 ( .A1(n17), .A2(n59), .A3(v7), .A4(n65), .Y(n55) );
  INVX1_RVT U143 ( .A(v8), .Y(n11) );
  AND3X1_RVT U144 ( .A1(n7), .A2(n15), .A3(v8), .Y(n21) );
  INVX0_RVT U145 ( .A(v3), .Y(n15) );
  INVX1_RVT U146 ( .A(n13), .Y(n70) );
  INVX1_RVT U147 ( .A(v0), .Y(n13) );
  NAND2X0_RVT U148 ( .A1(n49), .A2(n8), .Y(n41) );
  NAND2X0_RVT U149 ( .A1(n14), .A2(v0), .Y(n50) );
  AND2X1_RVT U150 ( .A1(n24), .A2(n23), .Y(Lv13_D_7) );
  AO22X1_RVT U151 ( .A1(n50), .A2(n20), .A3(n51), .A4(n9), .Y(n49) );
  INVX0_RVT U152 ( .A(n42), .Y(n9) );
  AO22X1_RVT U153 ( .A1(n62), .A2(v5), .A3(n23), .A4(n25), .Y(Lv13_D_6) );
  NAND2X0_RVT U154 ( .A1(n28), .A2(n29), .Y(Lv13_D_5) );
  AND2X1_RVT U155 ( .A1(n4), .A2(n35), .Y(n23) );
endmodule

