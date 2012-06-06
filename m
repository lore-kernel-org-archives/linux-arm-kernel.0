From: tony@atomide.com (Tony Lindgren)
Date: Wed, 06 Jun 2012 01:22:42 -0700
Subject: [PATCH 0/3] Few omap randconfig fixes for v3.5-rc1
Message-ID: <20120606082156.727.42730.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some fixes for review.

Regards,

Tony

---

Tony Lindgren (3):
      ARM: OMAP: Fix MMC_OMAP build when only MMC_OMAP_HS is selected
      ARM: OMAP3: Fix omap3_l3_block_irq warning when CONFIG_BUG is not set
      ARM: OMAP2+: Fix compile for CONFIG_TIDSPBRIDGE platform init code


 arch/arm/mach-omap2/dsp.c             |    3 +++
 arch/arm/mach-omap2/omap_l3_smx.c     |    3 ++-
 arch/arm/plat-omap/include/plat/mmc.h |    4 +---
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
Signature
