From: nico@cam.org (Nicolas Pitre)
Date: Mon, 24 Aug 2009 12:01:38 -0400 (EDT)
Subject: git pull request: small Orion/Kirkwood fixes for 2.6.31-rc
Message-ID: <alpine.LFD.2.00.0908241157210.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Since RMK is on vacation, could you please pull the following:

	git://git.marvell.com/orion fixes

This is based on v2.6.31-rc7 and contains 3 small fixes as follows:

John Holland (1):
      [ARM] Kirkwood: enable eSATA on QNAP TS-219P

Martin Michlmayr (1):
      [ARM] Kirkwood: __init requires linux/init.h

Simon Kagstrom (1):
      [ARM] Orion NAND: Make asm volatile avoid GCC pushing ldrd out of the loop

 arch/arm/configs/kirkwood_defconfig     |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c    |    9 +++++++++
 arch/arm/plat-orion/include/plat/gpio.h |    2 ++
 drivers/mtd/nand/orion_nand.c           |    2 +-
 4 files changed, 13 insertions(+), 2 deletions(-)


Nicolas
