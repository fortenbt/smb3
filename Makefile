.PHONY: all clean stock expanded bhop

# --------------------------------------------------
# Directories
# --------------------------------------------------

SRC       := src
COMMON    := $(SRC)/common
PRG       := $(COMMON)/PRG
STOCKSRC  := $(SRC)/stock
EXPDSRC   := $(SRC)/expanded

# ----- Music Engine Variants -----
MUSICNGIN := $(SRC)/music-engine
STOCKNGIN := $(MUSICNGIN)/stock
BHOPNGIN  := $(MUSICNGIN)/bhop

BUILD     := build
BSTOCK    := $(BUILD)/stock
BEXPD     := $(BUILD)/expanded
BBHOP     := $(BUILD)/expanded-bhop

INCLUDE   := include

ASFLAGS   := $(addprefix -I,$(INCLUDE) $(COMMON))

# --------------------------------------------------
# Output ROMs
# --------------------------------------------------

ROM_STOCK := smb3.nes
ROM_EXPD  := smb3-expanded.nes
ROM_BHOP  := smb3-bhop.nes

# --------------------------------------------------
# Sources
# --------------------------------------------------

COMMON_S   := $(wildcard $(COMMON)/*.s)
COMMON_PRG := $(wildcard $(PRG)/*.asm)

STOCK_S    := $(wildcard $(STOCKSRC)/*.s)
EXPD_S     := $(wildcard $(EXPDSRC)/*.s)

BHOP_S     := $(wildcard $(BHOPNGIN)/*.s)

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

# BHOP doesn't use the stock music engine (prg028)
BHOP_OBJS := \
	$(call map_common_s,expanded-bhop) \
	$(call map_common_prg,expanded-bhop) \
	$(patsubst $(EXPDSRC)/%.s,$(BBHOP)/%.o,$(EXPD_S)) \
	$(patsubst $(BHOPNGIN)/%.s,$(BBHOP)/%.o,$(BHOP_S))

# --------------------------------------------------
# Targets
# --------------------------------------------------

all: stock expanded bhop

stock: $(ROM_STOCK)
expanded: $(ROM_EXPD)
bhop: $(ROM_BHOP)

clean:
	rm -rf $(BUILD) $(ROM_STOCK) $(ROM_EXPD) $(ROM_BHOP) *.dbg


# --------------------------------------------------
# Build-specific variables
# --------------------------------------------------
$(ROM_STOCK): ASFLAGS += $(addprefix -I, $(STOCKSRC) $(STOCKNGIN)) 

$(ROM_EXPD) $(ROM_BHOP): ASFLAGS += -I$(EXPDSRC)
$(ROM_EXPD): ASFLAGS += -I$(STOCKNGIN)

$(ROM_BHOP): ASFLAGS += -I$(BHOPNGIN)
$(ROM_BHOP): DEFINES += -DBHOP

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

$(ROM_BHOP): $(BHOP_OBJS)
	ld65 -o $@ \
         -m $(BBHOP)/smb3.map \
         -C $(EXPDSRC)/mmc3.cfg \
         --dbgfile $(basename $@).dbg \
         $^

# --------------------------------------------------
# Compile rules
# --------------------------------------------------
# COMMON_RULES(build_dir, source files, music engine)
define COMMON_RULES
$1/common/%.o: $(COMMON)/%.s
	@mkdir -p $$(dir $$@)
	ca65 $$(ASFLAGS) $$(DEFINES) -o $$@ $$<

$1/common/PRG/%.o: $(PRG)/%.asm
	@mkdir -p $$(dir $$@)
	ca65 $$(ASFLAGS) $$(DEFINES) -o $$@ $$<

$1/%.o: $2/%.s
	@mkdir -p $$(dir $$@)
	ca65 $$(ASFLAGS) $$(DEFINES) -o $$@ $$<

$1/%.o: $3/%.s
	@mkdir -p $$(dir $$@)
	ca65 $$(ASFLAGS) $$(DEFINES) -o $$@ $$<
endef

# Common source for stock/expanded
$(eval $(call COMMON_RULES, $(BSTOCK), $(STOCKSRC), $(STOCKNGIN)))
$(eval $(call COMMON_RULES, $(BEXPD), $(EXPDSRC), $(STOCKNGIN)))
$(eval $(call COMMON_RULES, $(BBHOP), $(EXPDSRC), $(BHOPNGIN)))
