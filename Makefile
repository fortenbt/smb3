.PHONY: all clean dir run expanded stock

# ---- directories ----
SOURCEDIR  := src
COMMONDIR  := $(SOURCEDIR)/common
PRGDIR     := $(COMMONDIR)/PRG
EXPDDIR    := $(SOURCEDIR)/expanded
STOCKDIR   := $(SOURCEDIR)/stock
INCDIR     := include
BUILDDIR   := build

ASFLAGS += $(addprefix -I,$(INCDIR) $(COMMONDIR))

# ---- output ----
ROM_STOCK  := smb3.nes
ROM_EXPD   := smb3-expanded.nes

# ---- sources ----
# COMMON_S is the framework source that should be identical across ROMs
COMMON_S    := $(wildcard $(COMMONDIR)/*.s)
# COMMON_ASM is Southbird's original PRG/prgxxx.asm files
COMMON_ASM  := $(wildcard $(PRGDIR)/*.asm)
# STOCK_SRC is the source assembly written to reproduce the stock PRG1 ROM byte-for-byte
STOCK_SRC := $(wildcard $(STOCKDIR)/*.s)
# Expanded-only sources
EXPD_SRC  := $(wildcard $(EXPDDIR)/*.s)

# ---- objects ----
define make_objs
    $(patsubst $(SOURCEDIR)/%.s,$(BUILDDIR)/%.o,$(filter %.s,$1)) \
    $(patsubst $(SOURCEDIR)/%.asm,$(BUILDDIR)/%.o,$(filter %.asm,$1))
endef

STOCK_OBJS := $(call make_objs, $(STOCK_SRC) $(COMMON_S) $(COMMON_ASM))
EXPD_OBJS  := $(call make_objs, $(EXPD_SRC) $(COMMON_S) $(COMMON_ASM))

VPATH = $(SOURCEDIR) $(PRGDIR)

all: $(ROM_STOCK) $(ROM_EXPD)

expanded: $(ROM_EXPD)

stock: $(ROM_STOCK)

clean:
	@rm -rf $(BUILDDIR) $(ROM_STOCK) $(ROM_EXPD)

define BUILD_ROM
$1: CFG := $(SOURCEDIR)/$2/mmc3.cfg
$1: MAP := $(BUILDDIR)/map-$2.txt
$1: DBG := $(BUILDDIR)/smb3-$2.dbg
endef

$(eval $(call BUILD_ROM,$(ROM_STOCK),stock))
$(eval $(call BUILD_ROM,$(ROM_EXPD),expanded))

$(ROM_STOCK): $(STOCK_OBJS)
$(ROM_EXPD):  $(EXPD_OBJS)

$(ROM_STOCK) $(ROM_EXPD):
	ld65 -m $(MAP) \
	     --dbgfile $(DBG) \
	     -o $@ \
	     -C $(CFG) \
	     $^
$(BUILDDIR)/%.o: $(SOURCEDIR)/%.s
	@mkdir -p $(dir $@)
	ca65 -g $(ASFLAGS) --create-dep $(@:.o=.d) -o $@ $<

$(BUILDDIR)/%.o: $(SOURCEDIR)/%.asm
	@mkdir -p $(dir $@)
	ca65 -g $(ASFLAGS) --create-dep $(@:.o=.d) -o $@ $<

-include $(STOCK_OBJS:.o=.d) $(EXPD_OBJS:.o=.d)