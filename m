From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 18 Aug 2010 17:46:44 +0200
Subject: [PATCH 0/2] mx35_3ds mtd support
Message-ID: <1282146406-2901-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchseries includes support for the Spansion 64 NOR Flash and the
2GB Samsung MLC Nand Flash mtd devices on the mx35_3ds platform.

Marc Kleine-Budde (2):
  mx35_3ds: add physmap-flash NOR at CS0
  mx35_3ds: add NAND flash

 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/mach-mx35_3ds.c |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)
