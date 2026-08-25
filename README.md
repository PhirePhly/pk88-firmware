# AEA PK-88 firmware disassembly

Hand-maintained Z80 source for `pk88-27c256-e1744.bin` (Release 23.AUG.91).

## Hardware map

- CPU: Z80 at 4.9152 MHz
- EPROM: 32 KiB at `0x0000-0x7fff`
- Battery-backed SRAM: 32 KiB at `0x8000-0xffff`
- Z8530A channel A: control/status `0xf0`, data `0xf1`; Bell 202 modem / AX.25
- Z8530A channel B: control/status `0xf2`, data `0xf3`; user terminal serial port
- `0xf4`: board control latch (bit assignments not yet established)

The Z8530 assignments are inferred from firmware behavior: register-indexed initialization and modem-status polling occur through `0xf0`/`0xf1`; baud-generator setup and terminal transmit/receive occur through `0xf2`/`0xf3`. Port `0xf4` does not use the SCC register-select protocol and is therefore labeled as a separate board-control latch.

## Files

- `pk88.asm`: authoritative, annotated, buildable source
- `Makefile`: build and byte-for-byte verification
- `ANALYSIS.md`: named-routine catalog, confidence, and evidence
- `SCC.md`: decoded Z8530 register/value initialization tables
- `pk88-27c256-e1744.bin`: reference EPROM image used only for verification

`pk88.asm` is now the maintained source of truth. Edit labels, comments, code/data boundaries, and symbolic constants directly in it. Data and strings remain `defb` directives where needed to preserve exact bytes; high-bit-terminated strings have bit 7 set on their final character.

## Build and verify

Requirement: `z80asm`.

```sh
make
```

This assembles `build/pk88.bin`, compares it against the original ROM, and prints both SHA-256 hashes. The expected hash is:

```text
83ed9a668a3b9db2baa8fd86a116d8b70197553a1172b2464ad7ed8d84663c21
```

Use `make clean` to remove generated build output.
