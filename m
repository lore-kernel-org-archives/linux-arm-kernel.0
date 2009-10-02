From: tony@atomide.com (Tony Lindgren)
Date: Fri, 02 Oct 2009 15:36:23 -0700
Subject: [PATCH 0/8] Omap fixes for 2.6.32-rc2
Message-ID: <20091002223510.11962.21751.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some more fixes for review.

Regards,

Tony

---

Daniel Walker (1):
      omap: iovmm: Add missing mutex_unlock

Hiroshi DOYU (1):
      omap: iovmm: Fix incorrect spelling

Rajendra Nayak (1):
      omap: Lock DPLL5 at boot

Sergio Aguirre (1):
      omapfb: Condition mutex acquisition

Tommi Rantala (2):
      omapfb: Blizzard: constify register address tables
      omapfb: Blizzard: fix pointer to be const

Tony Lindgren (1):
      omap: Fix incorrect 730 vs 850 detection

ye janboe (1):
      omap: SRAM: flush the right address after memcpy in omap_sram_push


 arch/arm/mach-omap2/clock34xx.c       |   35 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/cpu.h |   37 ++++++++++++---------------------
 arch/arm/plat-omap/iovmm.c            |    9 ++++----
 arch/arm/plat-omap/sram.c             |    3 ++-
 drivers/video/omap/blizzard.c         |   10 ++++-----
 drivers/video/omap/omapfb_main.c      |   22 ++++++++++++--------
 6 files changed, 75 insertions(+), 41 deletions(-)

-- 
Signature
