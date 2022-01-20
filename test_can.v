module test_can (

  input          CLK,	
  input          RX,
  output         TX,    
  output [2:0]   LED

);

logic [25:0] cnt_clk;
logic [31:0] cnt_timer = 32'h0000_0000;
logic en_cnt = 0;   

assign LED[0] = cnt_clk[23];
assign LED[1] = TX;
assign LED[2] = RX;
     
always @(posedge CLK) begin
  cnt_clk <= cnt_clk + 1'b1;
end
    
always @(posedge CLK) begin
  if (~RX)
    en_cnt <=1;
end

always @(posedge CLK) begin
  if (en_cnt)
    cnt_timer <= cnt_timer +1'b1;
  else
    cnt_timer <=0;
end


always_comb begin
			  if (cnt_timer > 32'h0000_5911 & cnt_timer < 32'h0000_59d4) // ACK-field 0
				TX <=0; 
		else if (cnt_timer > 32'h0004_2a64 & cnt_timer < 32'h0004_2b2c) // SOF-field 0
				TX <=0; 
		else if (cnt_timer > 32'h0004_2f14 & cnt_timer < 32'h0004_2fdc) // Bitstuffing-field 0
				TX <=0;
		else if (cnt_timer > 32'h0004_30A4 & cnt_timer < 32'h0004_316c) // Identifier-field 0
				TX <=0;
		else if (cnt_timer > 32'h0004_3234 & cnt_timer < 32'h0004_361c) // Identifier-field 000, RTR-field 0, IDE-field 0
				TX <=0;
		else if (cnt_timer > 32'h0004_36e4 & cnt_timer < 32'h0004_37ac) // Reversed bit-field 0
				TX <=0;
		else if (cnt_timer > 32'h0004_3874 & cnt_timer < 32'h0004_3c5c) // DLC-field 000, DB0-field 00
				TX <=0;		
		else if (cnt_timer > 32'h0004_3d24 & cnt_timer < 32'h0004_3f7c) // DB0-field 000
				TX <=0;
		else if (cnt_timer > 32'h0004_410C & cnt_timer < 32'h0004_429c) // DB0-field 0, DB1-field 0
				TX <=0;
		else if (cnt_timer > 32'h0004_4364 & cnt_timer < 32'h0004_474c) // DB1-field 00000
				TX <=0;
		else if (cnt_timer > 32'h0004_48dc & cnt_timer < 32'h0004_4cc4) // DB2-field 00000
				TX <=0;
		else if (cnt_timer > 32'h0004_4d8c & cnt_timer < 32'h0004_4fe4) // DB2-field 000
				TX <=0;
		else if (cnt_timer > 32'h0004_50ac & cnt_timer < 32'h0004_5174) // DB3-field 0
				TX <=0;
		else if (cnt_timer > 32'h0004_555c & cnt_timer < 32'h0004_587c) // DB3-field 00, DB4-field 00
				TX <=0;
		else if (cnt_timer > 32'h0004_5c64 & cnt_timer < 32'h0004_5df4) // DB4-field 00
				TX <=0;
		else if (cnt_timer > 32'h0004_5ebc & cnt_timer < 32'h0004_5f84) // DB5-field 0
				TX <=0;
		else if (cnt_timer > 32'h0004_61dc & cnt_timer < 32'h0004_65c4) // DB5-field 000,DB6-field 00
				TX <=0;
		else if (cnt_timer > 32'h0004_668c & cnt_timer < 32'h0004_6754) // DB6-field 0
				TX <=0;
		else if (cnt_timer > 32'h0004_681c & cnt_timer < 32'h0004_69ac) // DB6-field 00
				TX <=0;
		else if (cnt_timer > 32'h0004_6b3c & cnt_timer < 32'h0004_6f24) // DB7-field 00000
				TX <=0;
		else if (cnt_timer > 32'h0004_6fec & cnt_timer < 32'h0004_7244) // DB7-field 000
				TX <=0;
		else if (cnt_timer > 32'h0004_73d4 & cnt_timer < 32'h0004_76f4) // CRC 0000
				TX <=0;
		else if (cnt_timer > 32'h0004_7a14 & cnt_timer < 32'h0004_7c6c) // CRC 000
				TX <=0;		
		else		
				TX <=1;
end				

endmodule
