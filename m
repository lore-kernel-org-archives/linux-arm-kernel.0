From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Oct 2009 17:13:28 -0700
Subject: [PATCH 0/6] omap fixes for v2.6.32-rc4
Message-ID: <20091014001233.6116.84749.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few omap fixes for review.

Regards,

Tony

---

Aaro Koskinen (1):
      omap: RX-51: Drop I2C-1 speed to 2200

Anuj Aggarwal (1):
      omap: SDMA: Fixing bug in omap_dma_set_global_params()

Jarkko Nikula (1):
      omap: McBSP: Fix incorrect receiver stop in omap_mcbsp_stop

Roel Kluin (1):
      omap: Fix Unlikely(x) < y

Sanjeev Premi (1):
      omap: CONFIG_ISP1301_OMAP redefined in Beagle defconfig

Teerth Reddy (1):
      omap: Initialization of SDRC params on Zoom2


 arch/arm/configs/omap3_beagle_defconfig      |    1 -
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom2.c            |    4 +++-
 arch/arm/plat-omap/dma.c                     |   15 +++++++++------
 arch/arm/plat-omap/gpio.c                    |    2 +-
 arch/arm/plat-omap/mcbsp.c                   |    2 +-
 6 files changed, 15 insertions(+), 11 deletions(-)

-- 
Signature
