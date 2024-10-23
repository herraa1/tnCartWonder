//
// i2s_audio_tx.sv
//
// BSD 3-Clause License
//
// Copyright (c) 2024, Albert Herranz
//
// Based on audio_drive.v from Tang Nano 20K audio example
//
// The design has been updated to match the timing diagrams of the
// MAX98357A datasheet (verified using verilator).
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
//    contributors may be used to endorse or promote products derived from
//    this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

`default_nettype none

/***********************************************************************
 * I2S Audio Transmitter
 ***********************************************************************/

module I2S_AUDIO_TX #(
    parameter                     SAMPLE_WIDTH = 16
) (
    input wire                    CLK_DAC,
    input wire                    RESET_n,
    input wire [SAMPLE_WIDTH-1:0] SAMPLE_IN,  // signed integer sample

    output wire                   REQ,        // data request signal
    output wire                   DAC_BCLK,   // I2S serial clock, aka Bit CLocK
    output wire                   DAC_LRCLK,  // I2S Left-Right CLocK
    output wire                   DAC_DIN     // I2S serial data (Data INto the MAX)
);
    localparam BIT_CNT_RESO  = 2 * SAMPLE_WIDTH;
    localparam BIT_CNT_WIDTH = $clog2(BIT_CNT_RESO);

    reg [SAMPLE_WIDTH-1:0] sample;   // temporary storage for sample shifting
    reg [BIT_CNT_WIDTH-1:0] bit_cnt; // counter for two samples
    reg req;      // data request signal
    reg reqd;     // 1-clock delayed req signal
    reg lrclk;    // left-right clock generation
    reg din;      // 1-bit serialized data

    assign REQ       = req;
    assign DAC_BCLK  = CLK_DAC;
    assign DAC_LRCLK = lrclk;
    assign DAC_DIN   = din;

    // bit_cnt
    always @(posedge CLK_DAC or negedge RESET_n)
    begin
        if(!RESET_n)                       bit_cnt <= 0;
        else if(bit_cnt == BIT_CNT_RESO-1) bit_cnt <= 0;
        else                               bit_cnt <= bit_cnt + 1'b1;
    end

    // req
    always @(negedge CLK_DAC or negedge RESET_n)
    begin
    if(!RESET_n)
        req <= 0;
    else
        // request a new sample every SAMPLE_WIDTH cycles
        req <= (bit_cnt == 0) || (bit_cnt == SAMPLE_WIDTH);
    end

    // sample
    always @(negedge CLK_DAC or negedge RESET_n)
    begin
        if(!RESET_n) begin
            reqd  <= 0;
            sample <= 0;
        end
        else begin
            // 1-clock delayed
            reqd <= req;
            // read new sample or shift left stored sample
            sample <= reqd ? SAMPLE_IN : {sample[SAMPLE_WIDTH-2:0], 1'b0};
        end
    end

    // din
    always @(negedge CLK_DAC or negedge RESET_n)
    begin
        if(!RESET_n)
            din <= 0;
        else
            din <= sample[SAMPLE_WIDTH-1]; // always output MSB
        end

    // lrclk
    always @(negedge CLK_DAC or negedge RESET_n)
    begin
        if(!RESET_n)
            lrclk <= 0;
        else
            lrclk <= (bit_cnt == 2) ? 0 : (bit_cnt == SAMPLE_WIDTH+2) ? 1 : lrclk; // data alignment
    end
endmodule

`default_nettype wire

