From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 14 Jan 2010 11:24:12 +0200
Subject: [PATCH 0/3] mx25: NAND support
Message-ID: <cover.1263460321.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for NAND chips on the i.MX25 platform, using the 
recently merged support for this platform in the mxc_nand driver.

I tested this code on the i.MX25 PDK platform.

Baruch Siach (3):
  mtd: mxc_nand: add MX25 to Kconfig
  mx25: add NAND support
  mx25pdk: add NAND device support

 arch/arm/mach-mx25/devices.c          |   20 ++++++++++++++++++++
 arch/arm/mach-mx25/devices.h          |    1 +
 arch/arm/mach-mx25/mx25pdk.c          |    7 +++++++
 arch/arm/plat-mxc/include/mach/mx25.h |    2 ++
 drivers/mtd/nand/Kconfig              |    2 +-
 5 files changed, 31 insertions(+), 1 deletions(-)
