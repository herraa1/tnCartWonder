//
// dac_16bit.sv
//
// BSD 3-Clause License
//
// Copyright (c) 2024, Albert Herranz
//
// Based on dac_1bit.sv
// Copyright (c) 2024, Shinobu Hashimoto
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
 * 16bit DAC module
 ***********************************************************************/
module DAC_16BIT (
    input wire                  CLK_DAC,
    input wire                  RESET_n,        // リセット信号

    SOUND_IF.IN                 IN,              // 再生信号

    output wire                 DAC_BCLK,
    output wire                 DAC_LRCLK,
    output wire                 DAC_DIN
);
    // IN_BIT_WIDTH should be less than 16
    localparam IN_BIT_WIDTH = $bits(IN.Signal);
    localparam OUT_BIT_WIDTH = 16;

    localparam [OUT_BIT_WIDTH - IN_BIT_WIDTH - 1 : 0] zero_bits = 0;

    I2S_AUDIO_TX i2s_audio_tx_inst (
        .CLK_DAC,
        .RESET_n,
        .SAMPLE_IN  ({IN.Signal, zero_bits}),
        .REQ        (),
        .DAC_BCLK,
        .DAC_LRCLK,
        .DAC_DIN
    );

endmodule

`default_nettype wire

