# smb3
Disassembly of Super Mario Bros 3

### Changes by 0r4ng33xp0

The goal of this repository is to add a small base of patches that
allow for much more featureful and robust ROM hack development.
After `git clone`ing this repository, you need to download the
submodules by running `git submodule update --init`.

Custom patches will also be available based on top of these base
patches, including a next gen music engine (`music-engine-ng`) and
On/Off Blocks (`on-off-block`).

I've added a Docker image within which is installed useful utilities
for building the ROM, patching the ROM, and editing the ROM. A `scuba`
script is provided to easily wrap usage of the Docker container. If
you do not have `scuba`, you can install it via `pip3 install scuba`.

```
$ scuba build
```

runs `nesasm smb3.asm` within the Docker container and produces the
ROM file `smb3.nes`. This ROM is the PRG1 version of the SMB3 ROM.

```
$ scuba foundry
```

launches Michael's new SMB3 ROM editor with TheJoeSmo's changes that
allow the expanded ROM to still be editable.

```
$ scuba ips-patch
```

runs the `ips-patch` utility, which takes as an argument an IPS patch
file and patches a given ROM from stdin, producing a patched ROM on
stdout.


### Original notes from Southbird

Specifically for use with NESASM (https://github.com/camsaul/nesasm), this will reassemble into a byte-for-byte perfect clone of Super Mario Bros. 3 US (PRG1)

NOTE: Included are support files for my "NoDice" level editor (game.xml and "icons" subdirectory) and "MusConv" (musconv.xml) utilities. They are not part of the actual source code required to build the ROM, but are necessary if you intend to use these tools.

-------------

To assemble, simply run:

nesasm smb3.asm

Intended for use for research into the inner workings of SMB3 and highly technical ROM hacks (such as Super Mario Bros. 3Mix)
