From: nm@ti.com (Nishanth Menon)
Date: Wed, 9 Sep 2015 16:18:10 -0500
Subject: [PATCH 0/4] ARM: OMAP5/DRA7: minor fixes
Message-ID: <1441833494-32450-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While doing a SoC only build for DRA7, a few bugs did pop up. The
following series provides necessary fixups for the same.

Nishanth Menon (4):
  ARM: OMAP4+: PM: erratum is used by OMAP5 and DRA7 as well
  ARM: omap2+: board-generic: Remove stale of_irq macros
  ARM: DRA7: Select missing options for SoC only build
  ARM: OMAP5: Cleanup options for SoC only build

 arch/arm/mach-omap2/Kconfig         |    6 +++++-
 arch/arm/mach-omap2/board-generic.c |    7 -------
 arch/arm/mach-omap2/pm.h            |    3 ++-
 3 files changed, 7 insertions(+), 9 deletions(-)

-- 
1.7.9.5
