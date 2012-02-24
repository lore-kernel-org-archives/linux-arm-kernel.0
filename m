From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 16:54:00 -0800
Subject: [PATCH 0/7] More omap2+ randconfig fixes
Message-ID: <20120224005324.16794.73852.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some more omap2+ randconfig related fixes for review.

Regards,

Tony

---

Tony Lindgren (7):
      ARM: OMAP2+: Fix Kconfig dependencies for USB_ARCH_HAS_EHCI
      ARM: OMAP2+: Fix OMAP_HDQ_BASE build error
      ARM: OMAP2+: Fix board_mux section type conflict when OMAP_MUX is not set
      ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is not selected
      ARM: OMAP2+: Fix devexit for smartreflex when CONFIG_HOTPLUG is not set
      ARM: OMAP: Fix devexit for dma when CONFIG_HOTPLUG is not set
      ARM: OMAP2+: Fix multiple randconfig errors with SOC_OMAP and SOC_OMAP_NOOP


 arch/arm/Makefile                        |    4 +-
 arch/arm/mach-omap2/Kconfig              |   55 ++++++++++++++++++++----------
 arch/arm/mach-omap2/board-zoom-display.c |    6 +++
 arch/arm/mach-omap2/devices.c            |    7 ++--
 arch/arm/mach-omap2/mux.h                |    2 +
 arch/arm/mach-omap2/smartreflex.c        |    2 +
 arch/arm/plat-omap/dma.c                 |    2 +
 7 files changed, 50 insertions(+), 28 deletions(-)

-- 
Signature
