/*
*  File            :   vga_debug_screen.sv
*  Data            :   2018.12.24
*  Language        :   SystemVerilog
*  Description     :   This is vga debug screen unit
*  Copyright(c)    :   2018 - 2019
*                      Barsukov Dmitriy
*                      Vlasov Dmitriy
*                      Stanislav Zhelnio
*/

`define cpu "nanoFOX"

module vga_debug_screen_50MHz
#(
    parameter                   bgColor = 12'h00f,
                                fgColor = 12'hf00
)(
    input   logic   [0  : 0]    clk,        // clock 
    input   logic   [0  : 0]    resetn,     // reset
    output  logic   [0  : 0]    hsync,      // hsync output
    output  logic   [0  : 0]    vsync,      // vsync output
    input   logic   [31 : 0]    regData,    // Register data input from cpu
    output  logic   [4  : 0]    regAddr,    // Register data output to cpu
    output  logic   [3  : 0]    R,          // R-color
    output  logic   [3  : 0]    G,          // G-color
    output  logic   [3  : 0]    B           // B-color
);

    logic   [0  : 0]    en;

    always_ff @(posedge clk, negedge resetn)
        if( !resetn )
            en <= '0;
        else
            en <= ~ en;

    vga_ds_top 
    #(
        .cpu        ( `cpu      )
    )
    vga_ds_top_0
    (
        .clk        ( clk       ),  // clock
        .resetn     ( resetn    ),  // reset
        .en         ( en        ),  // enable input
        .hsync      ( hsync     ),  // hsync output
        .vsync      ( vsync     ),  // vsync output
        .bgColor    ( bgColor   ),  // Background color
        .fgColor    ( fgColor   ),  // Foreground color
        .regData    ( regData   ),  // Register data input from cpu
        .regAddr    ( regAddr   ),  // Register data output to cpu
        .R          ( R         ),  // R-color
        .G          ( G         ),  // G-color
        .B          ( B         )   // B-color
    );

endmodule : vga_debug_screen_50MHz

module vga_debug_screen_pll_25_175MHz
#(
    parameter                   bgColor = 12'h00f,
                                fgColor = 12'hf00
)(
    input   logic   [0  : 0]    clk,        // clock 25.175 MHz from pll
    input   logic   [0  : 0]    resetn,     // reset
    output  logic   [0  : 0]    hsync,      // hsync output
    output  logic   [0  : 0]    vsync,      // vsync output
    input   logic   [31 : 0]    regData,    // Register data input from cpu
    output  logic   [4  : 0]    regAddr,    // Register data output to cpu
    output  logic   [3  : 0]    R,          // R-color
    output  logic   [3  : 0]    G,          // G-color
    output  logic   [3  : 0]    B           // B-color
);

    vga_ds_top 
    #(
        .cpu        ( `cpu      )
    )
    vga_ds_top_0
    (
        .clk        ( clk       ),  // clock
        .resetn     ( resetn    ),  // reset
        .en         ( '1        ),  // enable input
        .hsync      ( hsync     ),  // hsync output
        .vsync      ( vsync     ),  // vsync output
        .bgColor    ( bgColor   ),  // Background color
        .fgColor    ( fgColor   ),  // Foreground color
        .regData    ( regData   ),  // Register data input from cpu
        .regAddr    ( regAddr   ),  // Register data output to cpu
        .R          ( R         ),  // R-color
        .G          ( G         ),  // G-color
        .B          ( B         )   // B-color
    );

endmodule : vga_debug_screen_pll_25_175MHz
