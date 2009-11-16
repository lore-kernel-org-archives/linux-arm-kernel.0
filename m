From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 16 Nov 2009 06:36:49 -0700
Subject: [PATCH 0/3] OMAP clock and PM architecture fixes for 2.6.32-rc6
Message-ID: <20091116133237.14128.39687.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series contains fixes for some clock and PM architecture components
for the 2.6.32-rc series.

- Paul

---

Paul Walmsley (1):
      OMAP clock/hwmod: fix off-by-one errors

Rajendra Nayak (1):
      OMAP3 clock: Fix the DPLL freqsel computations

Tero Kristo (1):
      OMAP3: Clock: Fixed dpll3_m2x2 rate calculation


 arch/arm/mach-omap2/clock34xx.c  |    2 +-
 arch/arm/mach-omap2/clock34xx.h  |    4 ++--
 arch/arm/mach-omap2/cm.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c |   12 +++++-------
 arch/arm/mach-omap2/prcm.c       |    4 ++--
 5 files changed, 11 insertions(+), 13 deletions(-)
