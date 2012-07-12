From: stigge@antcom.de (Roland Stigge)
Date: Thu, 12 Jul 2012 14:35:21 +0200
Subject: [GIT PULL] ARM: LPC32xx: Adjust to pl08x DMA interface changes
Message-ID: <4FFEC489.5030307@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this is the pull request including the fix for the compile error caused by
lpc32xx-next and dma branches collisions in linux-next.

I submitted the respective changes in the MTD drivers separately as patches
to the mtd subsystem.

Thanks,

Roland



The following changes since commit dcdd1339a3cda33f216628142eea78f3d41b47fe:

  ARM: LPC32xx: Remove unused gpios (2012-07-01 21:06:45 +0200)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/core-fixes

for you to fetch changes up to 8ba85f8bffdfbac98dac8630406f7d020103db70:

  ARM: LPC32xx: Adjust to pl08x DMA interface changes (2012-07-12 14:25:37 +0200)

----------------------------------------------------------------
Roland Stigge (1):
      ARM: LPC32xx: Adjust to pl08x DMA interface changes

 arch/arm/mach-lpc32xx/phy3250.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
