//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 12:13:51 PM
// Design Name: 
// Module Name: SegDecoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module seg_decoder(
    input clk            , 
    input  [3:0] butcnt  , 
    output logic [7:0] cathode 
    );

  // Convert binary to decimal 7 segment display 
  always @ (posedge clk) begin
    case(butcnt)
         4'd0   : cathode = 8'b00000011;
         4'd1   : cathode = 8'b10011111; 
         4'd2   : cathode = 8'b00100101;
         4'd3   : cathode = 8'b00001101; 
         4'd4   : cathode = 8'b10011001; 
         4'd5   : cathode = 8'b01001001;
         4'd6   : cathode = 8'b11000001; 
         4'd7   : cathode = 8'b00011111;
         4'd8   : cathode = 8'b00000001;     
         4'd9   : cathode = 8'b00011001;
        default : cathode = 8'b11111100;
    endcase
   end
endmodule

