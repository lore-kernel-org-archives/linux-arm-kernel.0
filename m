From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:20 +0100
Subject: i.MX unnecessary ifdef removal
Message-ID: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches remove several unnecessary ifdefs in board
files.

Sascha

The following changes since commit 376e9c5848abef8c72c09bd89f2f7ee128caa104:

  ARM: mxs: add initial pm support (2011-01-26 08:30:49 +0100)

are available in the git repository at:
  none ..BRANCH.NOT.VERIFIED..

Sascha Hauer (13):
      ARM i.MX35 pcm043: remove unnecessary CONFIG_I2C ifdefs
      ARM i.MX35 pcm043: put usbh1 outside CONFIG_USB_ULPI
      ARM i.MX31 mx31ads: remove unnecessary CONFIG_I2C ifdefs
      ARM i.MX31 mx31ads: remove unnecessary CONFIG_SERIAL_IMX ifdefs
      ARM i.MX31 mx31ads: remove unnecessary CONFIG_SERIAL_8250 ifdefs
      ARM i.MX27 pca100: remove unnecessary CONFIG_SPI_IMX ifdefs
      ARM i.MX27 eukrea mbimx27: remove unnecessary CONFIG_SPI_IMX ifdefs
      ARM i.MX31 pcm037 eet: remove unnecessary CONFIG_SPI_IMX ifdefs
      ARM i.MX51 mx51 3ds: remove unnecessary CONFIG_SERIAL_IMX ifdefs
      ARM i.MX51 mx51 babbage: remove unnecessary CONFIG_SERIAL_IMX ifdefs
      ARM i.MX51 mx51 babbage: remove unnecessary CONFIG_KEYBOARD_IMX ifdefs
      ARM i.MX51 cpuimx51: remove unnecessary CONFIG_SERIAL_8250 ifdefs
      ARM i.MX51 efikamx: remove unnecessary CONFIG_SERIAL_IMX ifdefs

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    2 -
 arch/arm/mach-imx/mach-pca100.c              |    4 ---
 arch/arm/mach-mx3/mach-mx31ads.c             |   21 +-------------------
 arch/arm/mach-mx3/mach-pcm037_eet.c          |    2 -
 arch/arm/mach-mx3/mach-pcm043.c              |   10 ++------
 arch/arm/mach-mx5/board-cpuimx51.c           |    4 ---
 arch/arm/mach-mx5/board-mx51_3ds.c           |   27 ++++---------------------
 arch/arm/mach-mx5/board-mx51_babbage.c       |   19 ++++-------------
 arch/arm/mach-mx5/board-mx51_efikamx.c       |   17 ++-------------
 9 files changed, 17 insertions(+), 89 deletions(-)
