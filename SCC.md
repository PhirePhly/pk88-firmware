# Z8530 SCC initialization tables

The firmware programs the SCC by writing alternating register-number/value bytes to each channel's control port.

## Channel A — Bell 202 / AX.25 modem

Initial table at `0x07b7`:

| Register | Value |
|---:|---:|
| WR9 | `0x41` |
| WR4 | `0x04` |
| WR3 | `0xc0` |
| WR5 | `0xe2` |
| WR10 | `0x00` |
| WR11 | `0x56` |
| WR14 | `0x02` |
| WR3 | `0xc1` |
| WR12 | `0x02` |
| WR13 | `0x00` |
| WR14 | `0x03` |
| WR1 | `0x00` |
| WR15 | `0x00` |
| WR0 | `0x10` |
| WR0 | `0x10` |

Secondary table at `0x09ae`:

| Register | Value |
|---:|---:|
| WR14 | `0x03` |
| WR1 | `0x00` |
| WR15 | `0x98` |
| WR0 | `0x10` |
| WR0 | `0x10` |
| WR0 | `0x28` |
| WR1 | `0x13` |
| WR9 | `0x09` |

## Channel B — terminal serial port

First table at `0x090f`:

| Register | Value |
|---:|---:|
| WR9 | `0x81` |
| WR4 | `0x20` |
| WR2 | `0x00` |
| WR3 | `0xd8` |
| WR5 | `0x61` |
| WR6 | `0x00` |
| WR7 | `0x7e` |
| WR10 | `0xa0` |
| WR11 | `0x66` |

Second table at `0x0921`:

| Register | Value |
|---:|---:|
| WR14 | `0x82` |
| WR14 | `0xe2` |
| WR14 | `0x22` |
| WR3 | `0xd9` |
| WR5 | `0x69` |
| WR0 | `0x80` |
| WR0 | `0x40` |
| WR14 | `0x03` |
| WR1 | `0x00` |
| WR15 | `0xd8` |
| WR0 | `0x10` |
| WR0 | `0x10` |
| WR1 | `0x13` |
| WR9 | `0x09` |

These are literal register/value decodings. Individual bit meanings should be annotated against the Z8530A manual during the next hardware-focused pass.
