From: stigge@antcom.de (Roland Stigge)
Date: Tue, 25 Sep 2012 10:27:01 +0200
Subject: [GIT PULL] ARM: LPC32xx: Core updates #2
Message-ID: <50616AD5.3010104@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this is a second round of mach-lpc32xx specific updates for 3.7. Below,
the core branch.

Thanks,

Roland


The following changes since commit 7a5deff68f9e0a1db170ac9dd3b2b4aaddc1b80c:

  ARM: LPC32xx: Remove board specific GPIO init (2012-09-06 11:39:29 +0200)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/core

for you to fetch changes up to 8e4b97e3b8fd6a7f86bf8b38e7975549f2c48a78:

  ARM: LPC32xx: Support GPI 28 (2012-09-25 10:19:23 +0200)

----------------------------------------------------------------
Roland Stigge (3):
      ARM: LPC32xx: Board cleanup
      ARM: LPC32xx: Platform update for devicetree completion of spi-pl022
      ARM: LPC32xx: Support GPI 28

 arch/arm/mach-lpc32xx/include/mach/gpio-lpc32xx.h |    2 +-
 arch/arm/mach-lpc32xx/phy3250.c                   |   22 ++-------------------
 2 files changed, 3 insertions(+), 21 deletions(-)
