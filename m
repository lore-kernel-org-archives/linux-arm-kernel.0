From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  6 Dec 2011 14:41:25 +0100
Subject: [MXS MMC 0/5] Some cleanups and fixes for the MXS MMC subsystem
Message-ID: <cover.1323177907.git.LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lothar Wa??mann (5):
  Fix grammatical error in comment
  Some cleanups for the MMC driver
  Add support for SSP/MMC ports 2 & 3
  Check the return codes of clk_enable() and mxs_reset_block()
  Add an appropriate MODULE_ALIAS

 arch/arm/mach-mxs/clock-mx28.c               |    6 ++-
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c |    2 +
 drivers/mmc/host/mxs-mmc.c                   |   84 +++++++++++++++----------
 3 files changed, 57 insertions(+), 35 deletions(-)
