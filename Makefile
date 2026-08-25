ASM := pk88.asm
BUILD_DIR := build
OUTPUT := $(BUILD_DIR)/pk88.bin

.PHONY: all verify clean

all: $(OUTPUT)

$(BUILD_DIR):
	mkdir -p $@

$(OUTPUT): $(ASM) | $(BUILD_DIR)
	z80asm -o $@ $<

clean:
	rm -rf $(BUILD_DIR)
