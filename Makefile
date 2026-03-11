.PHONY: all clean stock expanded

# --------------------------------------------------
# Directories
# --------------------------------------------------

SRC       := src
COMMON    := $(SRC)/common
PRG       := $(COMMON)/PRG
STOCKSRC  := $(SRC)/stock
EXPDSRC   := $(SRC)/expanded

BUILD     := build
BSTOCK    := $(BUILD)/stock
BEXPD     := $(BUILD)/expanded

INCLUDE   := include

ASFLAGS   := $(addprefix -I,$(INCLUDE) $(COMMON))

# --------------------------------------------------
# Output ROMs
# --------------------------------------------------

ROM_STOCK := smb3.nes
ROM_EXPD  := smb3-expanded.nes

# --------------------------------------------------
# Sources
# --------------------------------------------------

COMMON_S   := $(wildcard $(COMMON)/*.s)
COMMON_PRG := $(wildcard $(PRG)/*.asm)

STOCK_S    := $(wildcard $(STOCKSRC)/*.s)
EXPD_S     := $(wildcard $(EXPDSRC)/*.s)

# --------------------------------------------------
# Object mapping helpers
# --------------------------------------------------

# common/*.s → build/<variant>/common/*.o
define map_common_s
	$(patsubst $(COMMON)/%.s,$(BUILD)/$1/common/%.o,$(COMMON_S))
endef

# PRG/*.asm → build/<variant>/common/PRG/*.o
define map_common_prg
	$(patsubst $(PRG)/%.asm,$(BUILD)/$1/common/PRG/%.o,$(COMMON_PRG))
endef

# --------------------------------------------------
# Object lists
# --------------------------------------------------

STOCK_OBJS := \
	$(call map_common_s,stock) \
	$(call map_common_prg,stock) \
	$(patsubst $(STOCKSRC)/%.s,$(BSTOCK)/%.o,$(STOCK_S))

EXPD_OBJS := \
	$(call map_common_s,expanded) \
	$(call map_common_prg,expanded) \
	$(patsubst $(EXPDSRC)/%.s,$(BEXPD)/%.o,$(EXPD_S))

# --------------------------------------------------
# Targets
# --------------------------------------------------

all: stock expanded

stock: $(ROM_STOCK)
expanded: $(ROM_EXPD)

clean:
	rm -rf $(BUILD) $(ROM_STOCK) $(ROM_EXPD)


# --------------------------------------------------
# Build-specific variables
# --------------------------------------------------
$(ROM_STOCK): ASFLAGS += -I$(STOCKSRC)

$(ROM_EXPD) $(ROM_BHOP): ASFLAGS += -I$(EXPDSRC)

# --------------------------------------------------
# Linking
# --------------------------------------------------
$(ROM_STOCK): $(STOCK_OBJS)
	ld65 -o $@ \
         -m $(BSTOCK)/smb3.map \
         -C $(STOCKSRC)/mmc3.cfg \
         --dbgfile $(basename $@).dbg \
         $^

$(ROM_EXPD): $(EXPD_OBJS)
	ld65 -o $@ \
         -m $(BEXPD)/smb3.map \
         -C $(EXPDSRC)/mmc3.cfg \
         --dbgfile $(basename $@).dbg \
         $^

# --------------------------------------------------
# Compile rules
# --------------------------------------------------
define COMMON_RULES
$1/common/%.o: $(COMMON)/%.s
	@mkdir -p $$(dir $$@)
	ca65 $$(ASFLAGS) -o $$@ $$<

$1/common/PRG/%.o: $(PRG)/%.asm
	@mkdir -p $$(dir $$@)
	ca65 $$(ASFLAGS) -o $$@ $$<

$1/%.o: $2/%.s
	@mkdir -p $$(dir $$@)
	ca65 $$(ASFLAGS) -o $$@ $$<
endef

# Common source for stock/expanded
$(eval $(call COMMON_RULES, $(BSTOCK), $(STOCKSRC)))
$(eval $(call COMMON_RULES, $(BEXPD), $(EXPDSRC)))
