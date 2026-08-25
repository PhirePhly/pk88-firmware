# AEA PK-88 firmware disassembly

Reproducible Z80 disassembly of `pk88-27c256-e1744.bin` (Release 23.AUG.91).

## Hardware map

- CPU: Z80 at 4.9152 MHz
- EPROM: 32 KiB at `0x0000-0x7fff`
- Battery-backed SRAM: 32 KiB at `0x8000-0xffff`
- Z8530A channel A: control/status `0xf0`, data `0xf1`; Bell 202 modem / AX.25
- Z8530A channel B: control/status `0xf2`, data `0xf3`; user terminal serial port
- `0xf4`: board control latch (bit assignments not yet established)

The Z8530 assignments are inferred from firmware behavior: register-indexed initialization and modem-status polling occur through `0xf0`/`0xf1`; baud-generator setup and terminal transmit/receive occur through `0xf2`/`0xf3`. Port `0xf4` does not use the SCC register-select protocol and is therefore labeled as a separate board control latch.

## Files

- `pk88.asm`: annotated, buildable source
- `Makefile`: build and byte-for-byte verification
- `ghidra-listing.tsv`: exported Ghidra recursive-disassembly result
- `ghidra-project/`: Ghidra 12.1.3 project
- `strings.tsv`: detected high-bit-terminated strings
- `pk88.blocks`: Ghidra-derived code/data boundaries for z80dasm
- `ghidra_scripts/ExportZ80Listing.java`: repeatable Ghidra export
- `tools/`: scripts that convert analysis into `pk88.asm`

Strings remain `defb` directives so their terminating character retains bit 7. Data and bytes not confidently identified by recursive analysis also remain `defb`; this prevents tables and text from being presented as invented code while preserving every byte.

## Build and verify

Requirements: `z80asm`, `z80dasm`, Python 3.

```sh
make
```

This assembles `build/pk88.bin`, compares it against the original ROM, and prints both SHA-256 hashes. The expected hash is:

```
83ed9a668a3b9db2baa8fd86a116d8b70197553a1172b2464ad7ed8d84663c21
```

To regenerate `pk88.asm` from the existing Ghidra export:

```sh
make disassemble
make verify
```

To rerun Ghidra from scratch, first remove the analysis project, then analyze and regenerate:

```sh
make reset-analysis
make ghidra GHIDRA_HOME=/path/to/ghidra_12.1.3_PUBLIC
make disassemble verify
```
