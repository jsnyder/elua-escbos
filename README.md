ESC Boston eLua Presentation Files
==================================

This repository contains a PDF of the latest slides used for the presentation as well as code.

To build the same image used in the presentation prepare a build environment as described in the eLua documenation for [Windows](http://www.eluaproject.net/doc/master/en_building_win.html) or [Linux](http://www.eluaproject.net/doc/master/en_building_unix.html).

Check the stm32f4-ws2812 branch of elua:

```bash
git clone https://github.com/jsnyder/elua elua
cd elua
git checkout stm32f4-ws2812
```

Next copy the autorun.lua from this directory to the elua/romfs from your just checked-out repository.

Finally build the image:

```bash
lua build_elua.lua board=nucleo-f411re toolchain=codesourcery prog
```

Copy the resulting elua_lua_nucleo-f411re.bin file to the mass storage of the device.

At this point the device should reboot into RPC mode with the default sequence running on port B pin 7.

To connect over RPC, locate the CDC device for your connected nucleo board (likely /dev/ttyS0 on linux beggining with /dev/tty.usbmodem on Mac OS X)

edit rpc_interface.lua to reflect the location of the serial port in the rpc.connect command.

build luarpc:

```bash
lua rpc-lua.lua
```
run luarpc, e.g.:

```bash
./luarpc -i rpc_interface.lua
```
