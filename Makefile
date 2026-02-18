.PHONY: all clean dir run expanded

# ---- directories ----
SOURCEDIR  := src
PRGDIR     := $(SOURCEDIR)/PRG
EXPDDIR    := $(SOURCEDIR)/expanded
INCDIR     := include
BUILDDIR   := build
BHOPDIR    := $(SOURCEDIR)/bhop

ASFLAGS += $(addprefix -I,$(INCDIR) $(SOURCEDIR))

# ---- output ----
ROM_STOCK  := smb3.nes
ROM_EXPD   := smb3-expanded.nes

# ---- sources ----
SRCS_BHOP   := $(SOURCEDIR)/bhop.s
STOCK_ASM   := $(wildcard $(PRGDIR)/*.asm)
#STOCK_S     := $(filter-out $(SRCS_BHOP), $(wildcard $(SOURCEDIR)/*.s))
STOCK_S     := $(wildcard $(SOURCEDIR)/*.s)
ALL_COMMON := $(STOCK_S) $(STOCK_ASM)

# ---- expanded sources except for the header, which is handled specially due to it being the same in the stock -----
#EXPD_ASM    := $(filter-out $(EXPDDIR)/header.s, $(wildcard $(EXPDDIR)/*.s) $(SRCS_BHOP))
EXPD_ASM    := $(filter-out $(EXPDDIR)/header.s, $(wildcard $(EXPDDIR)/*.s))

# ---- objects ----
COMMON_OBJS = \
  $(patsubst %.s,$(BUILDDIR)/%.o,$(notdir $(filter %.s,$(ALL_COMMON)))) \
  $(patsubst %.asm,$(BUILDDIR)/%.o,$(notdir $(filter %.asm,$(ALL_COMMON))))

EXPD_OBJS = \
  $(patsubst %.s,$(BUILDDIR)/%.o,$(notdir $(filter %.s,$(EXPD_ASM))))

VPATH = $(SOURCEDIR) $(PRGDIR)

all: $(ROM_STOCK) $(ROM_EXPD)

expanded: $(ROM_EXPD)

clean:
	@rm -rf $(BUILDDIR) $(ROM_STOCK) $(ROM_EXPD)

define BUILD_ROM
$1: CFG := $(SOURCEDIR)/$2/mmc3.cfg
$1: DBG := build/smb3-$2.dbg
$1: MAP := build/map-$2.txt
$1: $(COMMON_OBJS) $(BUILDDIR)/header-$2.o
endef

$(eval $(call BUILD_ROM,$(ROM_STOCK),stock))
$(eval $(call BUILD_ROM,$(ROM_EXPD),expanded))

$(ROM_EXPD): $(EXPD_OBJS)

$(ROM_STOCK) $(ROM_EXPD):
	ld65 -m $(MAP) \
	     --dbgfile $(DBG) \
	     -o $@ \
	     -C $(CFG) \
	     $^

$(BUILDDIR)/header-%.o: %/header.s
	@mkdir -p $(BUILDDIR)
	ca65 -g $(ASFLAGS) -o $@ $<

$(BUILDDIR)/%.o: $(EXPDDIR)/%.s
	@mkdir -p $(BUILDDIR)
	ca65 -g $(ASFLAGS) --create-dep $(@:.o=.d) -o $@ $<

$(BUILDDIR)/%.o: %.s
	@mkdir -p $(BUILDDIR)
	ca65 -g $(ASFLAGS) --create-dep $(@:.o=.d) -o $@ $<

$(BUILDDIR)/%.o: %.asm
	@mkdir -p $(BUILDDIR)
	ca65 -g $(ASFLAGS) --create-dep $(@:.o=.d) -o $@ $<

-include $(COMMON_OBJS:.o=.d)