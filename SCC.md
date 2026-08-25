# Z8530 SCC initialization tables

The firmware programs the SCC by writing alternating register-number/value bytes to each channel's control port.

## Z8530 Write Register Bit Definitions

### WR0 — Register Pointer / Commands
| Bit(s) | Name | Description |
|---|---|---|
| D2-D0 | Register Pointer | Selects WR0-WR15 for next write |
| D5-D3 | Command | 000=Null, 001=Send Abort (SDLC), 010=Reset Ext/Status Int, 011=Channel Reset, 100=Enable Int on Next Rx Char, 101=Reset Tx Int Pending, 110=Error Reset, 111=Return from Int (Ch A only) |
| D7-D6 | CRC Reset | 00=Null, 01=Reset Rx CRC Checker, 10=Reset Tx CRC Generator, 11=Reset Tx Underrun/EOM Latch |

### WR1 — Transmit/Receive Interrupt & Data Transfer Mode
| Bit | Name | Description |
|---|---|---|
| D0 | Ext/Status Int Enable | 1=Enable External/Status interrupts |
| D1 | Tx Int Enable | 1=Enable Transmit interrupts |
| D2 | Status Affects Vector | 1=Vector includes status (Ch B only) |
| D4-D3 | Rx Int Mode | 00=Rx Int Disable, 01=Rx Int on First Char, 10=Int on All Rx Char (Parity Affects Vector), 11=Int on All Rx Char (Parity No Effect) |
| D5 | WAIT/DMA Request Enable | 1=Enable WAIT/DMA Request |
| D6 | WAIT/DMA Request Function | 0=WAIT, 1=DMA Request |
| D7 | WAIT/DMA Request on Rx/Tx | 0=Tx, 1=Rx |

### WR2 — Interrupt Vector (Ch A only, shared)
| Bit | Description |
|---|---|
| D7-D0 | Interrupt Vector | Base interrupt vector (modified by status if WR1 D2=1 in Ch B) |

### WR3 — Receive Parameters & Control
| Bit | Name | Description |
|---|---|---|
| D0 | Rx Enable | 1=Enable Receiver |
| D1 | Sync Char Load Inhibit | 1=Ignore sync chars in SDLC/HDLC |
| D2 | Address Search Mode | 1=Only accept frames matching WR6/WR7 (SDLC) |
| D3 | Rx CRC Enable | 1=Enable Rx CRC |
| D4 | Enter Hunt Mode | 1=Enter Hunt mode (search for flag/sync) |
| D5 | Auto Enable | 1=Tx/Rx enabled by DCD/CTS pins |
| D7-D6 | Rx Bits/Char | 00=5, 01=6, 10=7, 11=8 bits/char |

### WR4 — Transmit/Receive Misc Parameters & Modes
| Bit | Name | Description |
|---|---|---|
| D0 | Parity Enable | 1=Enable Parity |
| D1 | Parity Even/Odd | 1=Even, 0=Odd |
| D2 | Sync Mode Enable | 1=Synchronous mode, 0=Asynchronous |
| D3 | 1 Stop Bit/Async | Async: 0=1 stop bit, 1=2 stop bits |
| D5-D4 | Sync Mode Select | 00=8-bit sync, 01=16-bit sync, 10=SDLC/HDLC, 11=External Sync |
| D7-D6 | Clock Mode | 00=1x, 01=16x, 10=32x, 11=64x clock rate |

### WR5 — Transmit Parameters & Control
| Bit | Name | Description |
|---|---|---|
| D0 | Tx CRC Enable | 1=Enable Tx CRC |
| D1 | RTS | 1=Assert RTS pin (active low) |
| D2 | SDLC/CRC-16 | 1=SDLC CRC, 0=CRC-16 |
| D3 | Tx Enable | 1=Enable Transmitter |
| D4 | Send Break | 1=Send continuous break (space) |
| D6-D5 | Tx Bits/Char | 00=5, 01=6, 10=7, 11=8 bits/char |
| D7 | DTR | 1=Assert DTR pin (active low) |

### WR6 — Sync Character / SDLC Address
| Bit | Description |
|---|---|
| D7-D0 | Sync Byte 0 / SDLC Address | Primary sync character or SDLC station address |

### WR7 — Sync Character / SDLC Flag
| Bit | Description |
|---|---|
| D7-D0 | Sync Byte 1 / SDLC Flag | Secondary sync character or SDLC flag (0x7E) |

### WR9 — Master Interrupt Control & Reset
| Bit | Name | Description |
|---|---|---|
| D0 | Ch B Reset | 1=Reset Channel B |
| D1 | Ch A Reset | 1=Reset Channel A |
| D2 | Force H/W Reset | 1=Force hardware reset (both channels) |
| D3 | Disable Lower Chain | 1=Disable lower priority daisy chain |
| D4 | Master Int Enable | 1=Master Interrupt Enable (MCS) |
| D5 | Status High/Status Low | 0=Status Low, 1=Status High |
| D7-D6 | Reset Type | 00=No Reset, 01=Ch B Reset, 10=Ch A Reset, 11=Force H/W Reset |

### WR10 — Miscellaneous Tx/Rx Control Bits
| Bit | Name | Description |
|---|---|---|
| D0 | 6-Bit/8-Bit Sync | 1=6-bit sync, 0=8-bit |
| D1 | Auto Tx Flag/CRC | 1=Auto flag/CRC in SDLC |
| D2 | Mark/Flag Idle | 1=Mark idle, 0=Flag idle (SDLC) |
| D3 | Go Active on Poll | 1=Go active on poll (SDLC loop) |
| D4 | Loop Mode | 1=SDLC Loop mode |
| D5 | CRC Preset | 1=CRC preset to 1, 0=CRC preset to 0 |
| D7-D6 | Data Encoding | 00=NRZ, 01=NRZI, 10=FM1 (transition=1), 11=FM0 (transition=0) |

### WR11 — Clock Mode Control
| Bit | Name | Description |
|---|---|---|
| D0 | Rx Clock = RTxC | 1=Rx clock from RTxC pin |
| D1 | Tx Clock = TRxC | 1=Tx clock from TRxC pin |
| D2 | TRxC = Baud Rate Gen | 1=TRxC outputs baud rate generator |
| D3 | TRxC = Xtal Output | 1=TRxC outputs crystal oscillator |
| D4 | Rx Clock = Baud Rate Gen | 1=Rx clock from BRG |
| D5 | Tx Clock = Baud Rate Gen | 1=Tx clock from BRG |
| D6 | RTxC = Xtal Output | 1=RTxC outputs crystal oscillator |
| D7 | RTxC = Baud Rate Gen | 1=RTxC outputs baud rate generator |

### WR12 — Lower Byte of Baud Rate Generator Time Constant
| Bit | Description |
|---|---|
| D7-D0 | TC Low | Lower 8 bits of 16-bit time constant |

### WR13 — Upper Byte of Baud Rate Generator Time Constant
| Bit | Description |
|---|---|
| D7-D0 | TC High | Upper 8 bits of 16-bit time constant |

### WR14 — Miscellaneous Control
| Bit | Name | Description |
|---|---|---|
| D0 | BRG Source | 0=RTxC pin, 1=PCLK (system clock) |
| D1 | BRG Enable | 1=Enable Baud Rate Generator |
| D2 | DTR/Request Function | 0=DTR, 1=Request Function |
| D3 | Auto Echo | 1=Auto Echo mode (loopback) |
| D4 | Local Loopback | 1=Local Loopback mode |
| D6-D5 | — | Reserved |
| D7 | — | Reserved (WR7' access enable in ESCC) |

### WR15 — External/Status Interrupt Control
| Bit | Name | Description |
|---|---|---|
| D0 | Zero Count IE | 1=Zero Count Int Enable (BRG) |
| D1 | DCD IE | 1=DCD Int Enable |
| D2 | Sync/Hunt IE | 1=Sync/Hunt Int Enable |
| D3 | CTS IE | 1=CTS Int Enable |
| D4 | Tx Underrun/EOM IE | 1=Tx Underrun/EOM Int Enable |
| D5 | Break/Abort IE | 1=Break/Abort Int Enable |
| D6 | — | Reserved |
| D7 | — | Reserved (FIFO enable in ESCC) |

---

## Channel A — Bell 202 / AX.25 modem (Port 0xF0/0xF1)

Initial table at `0x07b7`:

| Register | Value | Decoded Meaning |
|---|---|---|
| WR9 | `0x41` | Channel A Reset (D1=1) |
| WR4 | `0x04` | Async, 1 stop bit, 16x clock, no parity |
| WR3 | `0xc0` | Rx 8 bits/char, Rx disabled |
| WR5 | `0xe2` | Tx 8 bits/char, Tx enabled, RTS=1, SDLC CRC, Tx CRC enabled |
| WR10 | `0x00` | NRZ encoding, flag idle, CRC preset 0 |
| WR11 | `0x56` | Rx/Tx clock from BRG, TRxC=BRG out, RTxC=XTAL |
| WR14 | `0x02` | BRG source = PCLK |
| WR3 | `0xc1` | Rx 8 bits/char, Rx enabled |
| WR12 | `0x02` | BRG time constant low = 0x02 |
| WR13 | `0x00` | BRG time constant high = 0x00 |
| WR14 | `0x03` | BRG source = PCLK, BRG enabled |
| WR1 | `0x00` | All interrupts disabled |
| WR15 | `0x00` | All Ext/Status interrupts disabled |
| WR0 | `0x10` | Reset Ext/Status Interrupts |
| WR0 | `0x10` | Reset Ext/Status Interrupts |

Secondary table at `0x09ae`:

| Register | Value | Decoded Meaning |
|---|---|---|
| WR14 | `0x03` | BRG source = PCLK, BRG enabled |
| WR1 | `0x00` | All interrupts disabled |
| WR15 | `0x98` | DCD IE, CTS IE, Break/Abort IE enabled |
| WR0 | `0x10` | Reset Ext/Status Interrupts |
| WR0 | `0x10` | Reset Ext/Status Interrupts |
| WR0 | `0x28` | Channel Reset |
| WR1 | `0x13` | Rx Int on First Char, Ext/Status Int Enable, WAIT/DMA on Rx |
| WR9 | `0x09` | Master Int Enable (MCS), No Reset |

---

## Channel B — Terminal serial port (Port 0xF2/0xF3)

First table at `0x090f`:

| Register | Value | Decoded Meaning |
|---|---|---|
| WR9 | `0x81` | Channel B Reset (D0=1) |
| WR4 | `0x20` | Async, 1 stop bit, 16x clock, parity enabled (even) |
| WR2 | `0x00` | Interrupt vector = 0x00 |
| WR3 | `0xd8` | Rx 8 bits/char, Auto Enable, Rx CRC enabled, Rx enabled |
| WR5 | `0x61` | Tx 8 bits/char, Tx enabled, RTS=1, DTR=0, CRC-16 |
| WR6 | `0x00` | Sync byte 0 = 0x00 |
| WR7 | `0x7e` | Sync byte 1 / SDLC flag = 0x7E |
| WR10 | `0xa0` | NRZI encoding, flag idle, CRC preset 1 |
| WR11 | `0x66` | Rx/Tx clock from BRG, TRxC=BRG out, RTxC=XTAL |

Second table at `0x0921`:

| Register | Value | Decoded Meaning |
|---|---|---|
| WR14 | `0x82` | BRG source = PCLK (D7=1 accesses WR7'?) |
| WR14 | `0xe2` | BRG source = PCLK, BRG enabled, DTR/Req function |
| WR14 | `0x22` | BRG source = PCLK, DTR/Req function |
| WR3 | `0xd9` | Rx 8 bits/char, Auto Enable, Rx CRC enabled, Rx enabled, Sync Char Load Inhibit |
| WR5 | `0x69` | Tx 8 bits/char, Tx enabled, RTS=1, DTR=1, SDLC CRC, Tx CRC enabled |
| WR0 | `0x80` | Reset Tx Underrun/EOM Latch |
| WR0 | `0x40` | Error Reset |
| WR14 | `0x03` | BRG source = PCLK, BRG enabled |
| WR1 | `0x00` | All interrupts disabled |
| WR15 | `0xd8` | Zero Count IE, DCD IE, Sync/Hunt IE, CTS IE, Tx Underrun/EOM IE enabled |
| WR0 | `0x10` | Reset Ext/Status Interrupts |
| WR0 | `0x10` | Reset Ext/Status Interrupts |
| WR1 | `0x13` | Rx Int on First Char, Ext/Status Int Enable, WAIT/DMA on Rx |
| WR9 | `0x09` | Master Int Enable (MCS), No Reset |

---

These bit-field definitions are per the Zilog Z8530/AMD Am8530 SCC Technical Manual. Values in the tables above are literal firmware bytes; the "Decoded Meaning" column interprets each value using the register bit definitions.