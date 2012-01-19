From: b32955@freescale.com (Huang Shijie)
Date: Thu, 19 Jan 2012 15:53:38 +0800
Subject: [PATCH resent v2 0/2] ARM/mxs : add GPMI-NAND support for imx23/imx28
Message-ID: <1326959620-25920-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set has two patches:
[1] Add a new DEFINE_RES_DMA_SIZE_NAMED macro which used by the dma resource
    that has more then one dma source.
 
[2] add GPMI-NAND support for imx23/imx28

Huang Shijie (2):
  ioport : add DEFINE_RES_DMA_SIZE_NAMED macro
  ARM: mxs: add GPMI-NAND support for imx23/imx28

 arch/arm/mach-mxs/clock-mx23.c                  |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |    1 +
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi-nand.c  |   79 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 +++
 include/linux/ioport.h                          |    4 +-
 9 files changed, 106 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi-nand.c
