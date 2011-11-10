From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Nov 2011 16:39:28 +0800
Subject: [PATCH 0/4] imx: a few fixes for v3.2-rc
Message-ID: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Here are a few imx fixes targetting v3.2-rc.  Please have a review.
If it looks all good to you, I can send you a pull request if you want.

Shawn Guo (4):
      arm/imx: fix mx3_defconfig to add FEC back
      arm/imx: fix the references to ARCH_MX3
      arm/imx: fix AUTO_ZRELADDR selection
      arm/imx: fix imx6q mmc error when mounting rootfs

 arch/arm/configs/mx3_defconfig     |    1 +
 arch/arm/mach-imx/Makefile.boot    |   10 +++++++---
 arch/arm/mach-imx/clock-imx6q.c    |   17 ++++++++++++++++-
 arch/arm/plat-mxc/Kconfig          |    4 ++--
 drivers/dma/Kconfig                |    4 ++--
 drivers/mmc/host/sdhci-esdhc-imx.c |    8 ++++++++
 6 files changed, 36 insertions(+), 8 deletions(-)
