# tnCartWonder

This is a fork of the [tnCart](https://github.com/buppu3/tnCart) project by [Shinobu Hashimoto](https://github.com/buppu3) to make the RTL compatible with the [WonderTANG](https://github.com/lfantoniosi/WonderTANG) by [Luis Felipe Antoniosi](https://github.com/lfantoniosi).

See the [original README](https://github.com/buppu3/tnCart/blob/main/README.md) for more information.


# What is different between tnCart and tnCartWonder

There are really not many differences between tnCart and tnCartWonder. tnCartWonder inherits basically all from tnCart except some minor adaptions needed for compatibility with the WonderTANG! boards.


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

