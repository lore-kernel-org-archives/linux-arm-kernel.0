From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Feb 2010 14:07:16 -0800
Subject: [GIT PULL] omap fixes for 2.6.33-rc6
Message-ID: <20100204220716.GU22747@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony
The following changes since commit abe94c756c08d50566c09a65b9c7fe72f83071c5:
  Linus Torvalds (1):
        Linux 2.6.33-rc6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Kevin Hilman (2):
      OMAP2/3: IRQ: ensure valid base address
      OMAP2/3: GPMC: ensure valid clock pointer

Marek Skuczynski (1):
      omap: Fix access to already released memory in clk_debugfs_register_one()

Sriram (1):
      ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP

Tony Lindgren (4):
      omap: Remove old unused defines for OMAP_32KSYNCT_BASE
      omap: Fix 3630 mux errors
      omap: Fix arch/arm/mach-omap2/mux.c: Off by one error
      omap: Disable serial port autoidle by default

Uwe Kleine-K?nig (1):
      omap: define _toggle_gpio_edge_triggering only for OMAP1

 arch/arm/Kconfig                 |    1 +
 arch/arm/mach-omap2/gpmc.c       |    5 +++-
 arch/arm/mach-omap2/irq.c        |    4 ++-
 arch/arm/mach-omap2/mux.c        |   10 +++++++-
 arch/arm/mach-omap2/mux34xx.c    |   47 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/serial.c     |   11 +++++++-
 arch/arm/plat-omap/clock.c       |    4 +-
 arch/arm/plat-omap/gpio.c        |    4 +-
 arch/arm/plat-omap/omap_device.c |   10 --------
 9 files changed, 77 insertions(+), 19 deletions(-)
