From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 22:40:39 +0200
Subject: [GIT PULL] final arm-soc fixes for 3.1
Message-ID: <2473979.6NMHgbd7Ss@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are some last fixes from my side, please consider merging them into 3.1.
The majority of fixes that I received is now queued up in my next branch
for 3.2, but these are the ones that we agreed should still be merged before
the release.

	Arnd

The following changes since commit a102a9ece5489e1718cd7543aa079082450ac3a2:

  Linux 3.1-rc8 (2011-09-27 15:48:34 -0700)

are available in the git repository at:
  git://git.linaro.org/people/arnd/arm-soc.git fixes

Arnd Bergmann (1):
      Merge branch 'omap/fixes-for-3.1' into fixes

Axel Lin (1):
      ARM: OMAP: musb: Remove a redundant omap4430_phy_init call in usb_musb_init

Bryan Buckley (1):
      ARM: OMAP4: MMC: fix power and audio issue, decouple USBC1 from MMC1

Tony Lindgren (1):
      ARM: OMAP: Fix i2c init for twl4030

srinidhi kasagar (1):
      ARM: mach-ux500: enable fix for ARM errata 754322

 arch/arm/mach-omap2/board-2430sdp.c |    3 ++-
 arch/arm/mach-omap2/hsmmc.c         |   12 ++++--------
 arch/arm/mach-omap2/usb-musb.c      |    3 ---
 arch/arm/mach-ux500/Kconfig         |    1 +
 4 files changed, 7 insertions(+), 12 deletions(-)
