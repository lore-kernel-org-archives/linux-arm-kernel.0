From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 24 May 2013 17:42:31 +0200
Subject: [GIT PULL] at91: fixes for 3.10 #2
Message-ID: <1369410151-7837-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Second AT91 fixes pull-request for 3.10-rc. The PMC definition fix is the most
important of this batch.

Thanks, best regards,

The following changes since commit b7a8ca5173ef9aa55fa039d7c216426ff0b25a12:

  ARM: at91: rm9200 fix time support (2013-05-15 12:37:45 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 144ea15e4fefbee14a7dcb05c7cd0822fda3ebf6:

  ARM: at91/sama5: fix incorrect PMC pcr div definition (2013-05-24 10:53:51 +0200)

----------------------------------------------------------------
One definition fix that can lead to mis-clock some
AT91 peripherals on SAMA5.
Two DT related fixes.

----------------------------------------------------------------
Boris BREZILLON (1):
      ARM: at91/dt: fix macb pinctrl_macb_rmii_mii_alt definition

Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: at91sam9n12: move external irq declatation to DT

Josh Wu (1):
      ARM: at91/sama5: fix incorrect PMC pcr div definition

 arch/arm/boot/dts/at91sam9260.dtsi         | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi         | 1 +
 arch/arm/mach-at91/at91sam9n12.c           | 6 ------
 arch/arm/mach-at91/include/mach/at91_pmc.h | 6 +++---
 4 files changed, 5 insertions(+), 10 deletions(-)

-- 
Nicolas Ferre
