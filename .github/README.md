# tnCartWonder

This is a fork of the [tnCart](https://github.com/buppu3/tnCart) project by [Shinobu Hashimoto](https://github.com/buppu3) to make the RTL compatible with the [WonderTANG](https://github.com/lfantoniosi/WonderTANG) by [Luis Felipe Antoniosi](https://github.com/lfantoniosi).

See the [original README](https://github.com/buppu3/tnCart/blob/main/README.md) for more information.


# What is different between tnCart and tnCartWonder

There are really not many differences between tnCartWonder and tnCart. tnCartWonder inherits basically all from tnCart except some minor adaptions needed for compatibility with the WonderTANG! boards.

For WonderTANG! V2.0b, these are the differences:
- Swap the MSEL0 and MSEL1 signals of the tnCart rev1 board to match those of the WonderTANG! V2.0b board
- Adjust the pin mapping of the tnCart rev1 board (which uses the mapping of the WonderTANG! V1.01c and V1.02d boards) to that of the WonderTANG! V2.0b board
- Add code to "send" the external sound samples (which in the tnCart are processed by a synthesized 1-bit DAC) to a synthesized I2S transmitter that sends audio samples to the [MAX98357A](https://www.analog.com/media/en/technical-documentation/data-sheets/max98357a-max98357b.pdf) of the [Tang Nano 20k](https://wiki.sipeed.com/hardware/en/tang/tang-nano-20k/nano-20k.html) (whose output the WonderTANG! V2.0b board sends to both the jack audio and the SOUNDIN pin of the MSX cartridge).

For WonderTANG! V1.02d, these are the differences:
- Swap the MSEL0 and MSEL1 signals of the tnCart rev1 board to match those of the WonderTANG! V1.02d board

For WonderTANG! V1.01c, these are the differences:
- Swap the MSEL0 and MSEL1 signals of the tnCart rev1 board to match those of the WonderTANG! V1.01c board
- Invert the INT_n signal (in the WonderTANG! V1.01c the INT_n signal logic is direct, in tnCart rev1 board the INT_n signal logic is inverted)

# Build and Flashing instructions

> [!NOTE]
> Since commit [Modify config.sv regarding board configuration](https://github.com/buppu3/tnCart/commit/7444c95f78c784e03bb0775b3e52caf16ae9ec27) tnCart provides bitstreams
> for WonderTANG! V1.02d and WonderTANG! V1.01c boards. The bitstream for WonderTANG! V2.00b boards is provided here.

## WonderTANG 2.0b

### How to build the bitstream on Linux

- Launch GoWin IDE (GOWIN FPGA Designer Version V1.9.9.03 Education build(73833))

  ~~~Shell
  gw_ide
  ~~~

- Load the `rtl/tnCart_board_wt200b.gprj` (File | Open ...)

- Edit the `rtl/src/config.v` enabling and/or disabling the tnCart features that you want to build.

- Go to the Process window, right click on "Synthesize" and select "Clean&Rerun All"

### How to flash the bitstream and required additional ROMs on Linux

You will need to use openFPGALoader >= v0.10.0.

- First, flash the bitstream [`tnCart_board_wt200b.fs`](https://raw.githubusercontent.com/herraa1/tnCartWonder/main/rtl/impl/pnr/tnCart_board_wt200b.fs) into the Tang Nano 20k used in your WonderTANG board

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash rtl/impl/pnr/tnCart_board_wt200b.fs
  ~~~

- Second, flash the [Nextor ROM](https://github.com/Konamiman/Nextor/releases/download/v2.1.2/Nextor-2.1.2.MegaFlashSDSCC.1-slot.ROM)

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash -o 1048576 Nextor-2.1.2.MegaFlashSDSCC.1-slot.ROM
  ~~~

- Finally, flash the [FM ROM](https://github.com/buppu3/tnCart/blob/main/roms/fmbios/bin/fmbios.rom)

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash -o 1179648 fmbios.rom
  ~~~

## WonderTANG 1.02d

### How to build the bitstream on Linux

- Launch GoWin IDE (GOWIN FPGA Designer Version V1.9.9.03 Education build(73833))

  ~~~Shell
  gw_ide
  ~~~

- Load the `rtl/tnCart_board_wt102d.gprj` (File | Open ...)

- Edit the `rtl/src/config.v` enabling and/or disabling the tnCart features that you want to build.

- Go to the Process window, right click on "Synthesize" and select "Clean&Rerun All"

### How to flash the bitstream and required additional ROMs on Linux

You will need to use openFPGALoader >= v0.10.0.

- First, flash the bitstream [`tnCart_board_wt102d.fs`](https://raw.githubusercontent.com/herraa1/tnCartWonder/main/rtl/impl/pnr/tnCart_board_wt102d.fs) into the Tang Nano 20k used in your WonderTANG board

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash rtl/impl/pnr/tnCart_board_wt102d.fs
  ~~~

- Second, flash the [Nextor ROM](https://github.com/Konamiman/Nextor/releases/download/v2.1.2/Nextor-2.1.2.MegaFlashSDSCC.1-slot.ROM)

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash -o 1048576 Nextor-2.1.2.MegaFlashSDSCC.1-slot.ROM
  ~~~

- Finally, flash the [FM ROM](https://github.com/buppu3/tnCart/blob/main/roms/fmbios/bin/fmbios.rom)

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash -o 1179648 fmbios.rom
  ~~~

## WonderTANG 1.01c

### How to build the bitstream on Linux

- Launch GoWin IDE (GOWIN FPGA Designer Version V1.9.9.03 Education build(73833))

  ~~~Shell
  gw_ide
  ~~~

- Load the `rtl/tnCart_board_wt101c.gprj` (File | Open ...)

- Edit the `rtl/src/config.v` enabling and/or disabling the tnCart features that you want to build.

- Go to the Process window, right click on "Synthesize" and select "Clean&Rerun All"

### How to flash the bitstream and required additional ROMs on Linux

You will need to use openFPGALoader >= v0.10.0.

- First, flash the bitstream [`tnCart_board_wt101c.fs`](https://raw.githubusercontent.com/herraa1/tnCartWonder/main/rtl/impl/pnr/tnCart_board_wt101c.fs) into the Tang Nano 20k used in your WonderTANG board

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash rtl/impl/pnr/tnCart_board_wt101c.fs
  ~~~

- Second, flash the [Nextor ROM](https://github.com/Konamiman/Nextor/releases/download/v2.1.2/Nextor-2.1.2.MegaFlashSDSCC.1-slot.ROM)

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash -o 1048576 Nextor-2.1.2.MegaFlashSDSCC.1-slot.ROM
  ~~~

- Finally, flash the [FM ROM](https://github.com/buppu3/tnCart/blob/main/roms/fmbios/bin/fmbios.rom)

  ~~~Shell
  openFPGALoader -f -b tangnano20k --external-flash -o 1179648 fmbios.rom
  ~~~


# Useful Information

## How to load a Konami SCC ROM with tncrom

You can use the [TNCROM.COM](https://github.com/buppu3/tnCart/blob/main/tools/tncrom/bin/TNCROM.COM) tool to load ROMs into the WonderTANG MegaFlashROM when flashed with the tnCart RTL.

`A:> TNCROM.COM /T KONAMI /R YOUR.ROM`

With the above invocation the ROM gets loaded, and the `/R` parameter causes an immediate system reset to launch the ROM.

The `/R` parameter is useful to force a reset on those MSX machines lacking a reset button.
If your MSX has a reset button, you may omit the `/R` parameter and use the reset button when you want to launch the loaded ROM.

## How to activate the SCC with tncrom

You can use the [TNCROM.COM](https://github.com/buppu3/tnCart/blob/main/tools/tncrom/bin/TNCROM.COM) tool to activate the SCC before launching software that uses it, like MGSP or SofaRun.

`A:> TNCROM.COM /T KONAMI_SCC_I /N`

With the above invocation the SCC_I is activated and control is returned to DOS.


# Known Issues

- [tnCart #14](https://github.com/buppu3/tnCart/issues/14)

