ASM := pk88.asm
BUILD_DIR := build
OUTPUT := $(BUILD_DIR)/pk88.bin
ORIGINAL_SHA256 := 83ed9a668a3b9db2baa8fd86a116d8b70197553a1172b2464ad7ed8d84663c21

.PHONY: all verify clean

all: $(OUTPUT)

$(BUILD_DIR):
	mkdir -p $@

$(OUTPUT): $(ASM) | $(BUILD_DIR)
	z80asm -o $@ $<

verify: $(OUTPUT)
	@echo "Verifying rebuild against original..."
	@expected="$$(printf '%s  %s\n' '$(ORIGINAL_SHA256)' '$(OUTPUT)')"
	@actual="$$(sha256sum '$(OUTPUT)')"
	@if [ "$$expected" = "$$actual" ]; then \
		echo "OK: $(OUTPUT) matches original (byte-for-byte)"; \
	else \
		echo "MISMATCH!"; \
		echo "  expected: $$expected"; \
		echo "  actual:   $$actual"; \
		exit 1; \
	fi

clean:
	rm -rf $(BUILD_DIR)
