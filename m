From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Oct 2010 12:55:20 +0200
Subject: [PATCH 0/3] add resources for SD/MMC on i.MX3
Message-ID: <1286794523-26607-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches were tested on a Phytec phyCORE-i.MX35. They are based on Sascha's
branch 'imx-for-2.6.37'.

Wolfram Sang (3):
  arm: imx: add generic esdhc device
  arm: imx35: add esdhc-device to MX35-platform
  arm: pcm043: add esdhc-device to boardconfig

 arch/arm/mach-mx3/Kconfig                       |    1 +
 arch/arm/mach-mx3/clock-imx35.c                 |    6 ++--
 arch/arm/mach-mx3/devices-imx35.h               |    7 +++++
 arch/arm/mach-mx3/mach-pcm043.c                 |    8 ++++++
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-esdhc.c      |   31 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    6 ++++
 arch/arm/plat-mxc/include/mach/esdhc.h          |   16 ++++++++++++
 arch/arm/plat-mxc/include/mach/mx35.h           |    3 ++
 10 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-esdhc.c
 create mode 100644 arch/arm/plat-mxc/include/mach/esdhc.h
