From: stigge@antcom.de (Roland Stigge)
Date: Sun, 01 Jul 2012 21:22:24 +0200
Subject: [GIT PULL] arm-soc: lpc32xx: platform updates
Message-ID: <4FF0A370.10704@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this pull request includes the platform topic branch for lpc32xx. It
builds upon the branch lpc32xx-next that you already pulled into
arm-soc.git.

Thanks in advance,

Roland


The following changes since commit df072717eb0050326f0f63eed98200412c395831:

  ARM: LPC32xx: Move i2s1 dma enabling to clock.c (2012-06-14 16:16:19 +0200)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/core

for you to fetch changes up to dcdd1339a3cda33f216628142eea78f3d41b47fe:

  ARM: LPC32xx: Remove unused gpios (2012-07-01 21:06:45 +0200)

----------------------------------------------------------------
Alexandre Pereira da Silva (2):
      ARM: LPC32xx: Cleanup USB clock init
      ARM: LPC32xx: Remove unused gpios

Roland Stigge (4):
      ARM: LPC32xx: Init MMC via clock
      ARM: LPC32xx: Add further bits to MMC init
      ARM: LPC32xx: Remove wrong re-initialization of MMC clock register
      ARM: LPC32xx: Remove USB and I2C init from phy3250.c

 arch/arm/mach-lpc32xx/clock.c                 |   88 ++++++++++++++++++++++---
 arch/arm/mach-lpc32xx/include/mach/platform.h |   14 ++++
 arch/arm/mach-lpc32xx/phy3250.c               |   20 ------
 3 files changed, 92 insertions(+), 30 deletions(-)
