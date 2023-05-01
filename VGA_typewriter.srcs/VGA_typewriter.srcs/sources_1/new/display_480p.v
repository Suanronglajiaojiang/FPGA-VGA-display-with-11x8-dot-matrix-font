module display_480p #(
        parameter CORDW = 16,
        parameter H_RES = 640,
        parameter V_RES = 480,
        parameter H_FP = 16,
        parameter H_SYNC = 96,
        parameter H_BP = 48,
        parameter V_FP = 10,
        parameter V_SYNC = 2,
        parameter V_BP = 33,
        parameter H_POL = 0,
        parameter V_POL = 0,
        parameter H_OFFSET = 2,
        parameter SCALE = 8,
        parameter CHARA_WIDTH = 8,
        parameter CHARA_HEIGHT = 11,
        parameter GRID_ROW = 5,
        parameter GRID_COL = 10,
        parameter signed  H_STA = -((H_FP + H_SYNC) + H_BP),
        parameter signed  V_STA = -((V_FP + V_SYNC) + V_BP)
 )(
        input wire clk_pix,                
        input wire rst_pix,                
        output reg hsync = 1,                 
        output reg vsync = 1,                  
        output reg de = 0,                     
        output reg frame = 0,                  
        output reg line = 0,                   
        output reg signed [CORDW - 1:0] sx = H_STA,
        output reg signed [CORDW - 1:0] sy = V_STA
);
        

        localparam signed  HS_STA = H_STA + H_FP;
        localparam signed  HS_END = HS_STA + H_SYNC;
        localparam signed  HA_STA = 0;
        localparam signed  HA_END = H_RES - 1;
        
        localparam signed  VS_STA = V_STA + V_FP;
        localparam signed  VS_END = VS_STA + V_SYNC;
        localparam signed  VA_STA = 0;
        localparam signed  VA_END = V_RES - 1;
        
        // reg signed [CORDW - 1:0] x;
        // reg signed [CORDW - 1:0] y;

        
        always @(posedge clk_pix) begin
                hsync <= (H_POL ? (sx > HS_STA) && (sx <= HS_END) : ~((sx > HS_STA) && (sx <= HS_END)));
                vsync <= (V_POL ? (sy > VS_STA) && (sy <= VS_END) : ~((sy > VS_STA) && (sy <= VS_END)));
                if (rst_pix) begin
                        hsync <= (H_POL ? 0 : 1);
                        vsync <= (V_POL ? 0 : 1);
                end
        end
        always @(posedge clk_pix) begin
                de <= (sy >= VA_STA && sy < CHARA_HEIGHT*SCALE*GRID_ROW) && (sx >= HA_STA && sx < CHARA_WIDTH*SCALE*GRID_COL);
                frame <= (sy == V_STA) && (sx == H_STA);
                line <= sx == H_STA;
                if (rst_pix) begin
                        de <= 0;
                        frame <= 0;
                        line <= 0;
                end
        end
        always @(posedge clk_pix) begin
                if (sx == HA_END) begin
                        sx <= H_STA;
                        sy <= (sy == VA_END ? V_STA : sy + 1);
                end
                else
                        sx <= sx + 1;
                if (rst_pix) begin
                        sx <= H_STA;
                        sy <= V_STA;
                end
        end
        // always @(posedge clk_pix) begin
                // sx <= x;
                // sy <= y;
                // if (rst_pix) begin
                        // sx <= H_STA;
                        // sy <= V_STA;
                // end
        // end
endmodule