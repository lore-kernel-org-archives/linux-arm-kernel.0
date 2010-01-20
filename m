From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jan 2010 13:23:29 -0800
Subject: [PATCH 0/4] omap fixes for 2.6.33-rc4
Message-ID: <20100120212248.25335.55761.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Roel Kluin (1):
      OMAP: dma_chan[lch_head].flag & OMAP_DMA_ACTIVE tested twice in omap_dma_unlink_lch()

Tony Lindgren (3):
      omap: Fix cmdline muxing
      omap: Fix functions for dynamic remuxing of pins
      omap3: Fix cpu detection


 arch/arm/mach-omap2/id.c              |   41 +++++++++++++++++++--------------
 arch/arm/mach-omap2/mux.c             |   27 ++++++++++++----------
 arch/arm/mach-omap2/mux.h             |   24 +++++++++++++++++++
 arch/arm/plat-omap/dma.c              |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h |    1 +
 5 files changed, 64 insertions(+), 31 deletions(-)

-- 
Signature
