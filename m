From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Dec 2009 14:35:20 -0800
Subject: [GIT PULL] omap build fixes
Message-ID: <20091216223520.GV4575@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull omap build fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

In addition to the three build fixes, there's also a suspend fix
for omap serial init.

Regards,

Tony


The following changes since commit 8bea8672edfca7ec5f661cafb218f1205863b343:
  Stephen Rothwell (1):
        mfd: compile fix for twl4030 renaming

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Balaji T K (1):
      mfd: twl: fix twl4030 rename for remaining driver, board files

Mika Westerberg (1):
      OMAP3: serial - fix bug introduced in

Olof Johansson (1):
      omap3: Allow EHCI to be built on OMAP3

Thomas Weber (1):
      USB ehci: replace mach header with plat

 arch/arm/mach-omap2/Kconfig                  |    1 +
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/serial.c                 |    7 ++++---
 drivers/usb/host/ehci-omap.c                 |    2 +-
 drivers/video/omap/lcd_ldp.c                 |    4 ++--
 drivers/video/omap/lcd_omap2evm.c            |   10 +++++-----
 drivers/video/omap/lcd_omap3beagle.c         |    2 +-
 drivers/video/omap/lcd_omap3evm.c            |   10 +++++-----
 drivers/video/omap/lcd_overo.c               |    2 +-
 sound/soc/omap/sdp3430.c                     |    6 +++---
 15 files changed, 29 insertions(+), 27 deletions(-)
