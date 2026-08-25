ROM := pk88-27c256-e1744.bin
ASM := pk88.asm
RAW_ASM := pk88.raw.asm
BUILD_DIR := build
OUTPUT := $(BUILD_DIR)/pk88.bin
GHIDRA_HOME ?= /home/kenneth/tmp/ghidra/ghidra_12.1.3_PUBLIC
ANALYZE_HEADLESS := $(GHIDRA_HOME)/support/analyzeHeadless
GHIDRA_PROJECT_DIR := ghidra-project
GHIDRA_PROJECT := PK88

.PHONY: all verify clean disassemble ghidra reset-analysis

all: verify

$(BUILD_DIR):
	mkdir -p $@

$(OUTPUT): $(ASM) | $(BUILD_DIR)
	z80asm -o $@ $<

verify: $(OUTPUT)
	cmp $(ROM) $(OUTPUT)
	@sha256sum $(ROM) $(OUTPUT)
	@echo "Verified: $(OUTPUT) is byte-for-byte identical to $(ROM)"

# Recreate the source from the checked-in Ghidra analysis listing.
disassemble: ghidra-listing.tsv tools/generate_blocks.py tools/enrich_asm.py
	python3 tools/generate_blocks.py
	z80dasm -a -l -g 0 -b pk88.blocks -o $(RAW_ASM) $(ROM)
	python3 tools/enrich_asm.py $(RAW_ASM) $(ASM)

# Repeat Ghidra headless analysis after `make reset-analysis`.
ghidra: ghidra-listing.tsv

ghidra-listing.tsv: $(ROM) ghidra_scripts/ExportZ80Listing.java
	@test -x "$(ANALYZE_HEADLESS)" || { echo "Ghidra not found at $(GHIDRA_HOME)"; exit 1; }
	mkdir -p $(GHIDRA_PROJECT_DIR)
	$(ANALYZE_HEADLESS) $(CURDIR)/$(GHIDRA_PROJECT_DIR) $(GHIDRA_PROJECT) \
		-import $(CURDIR)/$(ROM) \
		-processor z80:LE:16:default -loader BinaryLoader -loader-baseAddr 0x0000 \
		-scriptPath $(CURDIR)/ghidra_scripts \
		-postScript ExportZ80Listing.java $(CURDIR)/ghidra-listing.tsv

reset-analysis:
	rm -rf $(GHIDRA_PROJECT_DIR) ghidra-listing.tsv pk88.blocks strings.tsv $(RAW_ASM)

clean:
	rm -rf $(BUILD_DIR) $(RAW_ASM)
