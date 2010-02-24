From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 24 Feb 2010 12:57:28 -0500 (EST)
Subject: Git pull request: more Kirkwood/MV78xx0 stuff
Message-ID: <alpine.LFD.2.00.1002241251260.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull:

	git://git.marvell.com/orion for-rmk

This adds support for the eSATA SheevaPlug and the Terastation Duo.

John Holland (3):
      [ARM] eSATA SheevaPlug basic board support
      [ARM] eSATA SheevaPlug: configure SoC SATA interface
      [ARM] eSATA SheevaPlug: correlate MPP to SD CD and SD WP

Sebastien Requiem (2):
      [ARM]?MV78XX0: MPP routines and definitions
      [ARM] MV78xx0: Support for Buffalo WXL (Terastation Duo)

 arch/arm/configs/mv78xx0_defconfig        |    1 +
 arch/arm/mach-kirkwood/Kconfig            |    6 +
 arch/arm/mach-kirkwood/Makefile           |    1 +
 arch/arm/mach-kirkwood/sheevaplug-setup.c |   50 +++-
 arch/arm/mach-mv78xx0/Kconfig             |    6 +
 arch/arm/mach-mv78xx0/Makefile            |    3 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c |  155 ++++++++++
 arch/arm/mach-mv78xx0/mpp.c               |   96 +++++++
 arch/arm/mach-mv78xx0/mpp.h               |  347 +++++++++++++++++++++++
 9 files changed, 662 insertions(+), 3 deletions(-)


Nicolas
