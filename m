From: r65037@freescale.com (Richard Zhu)
Date: Wed, 20 Oct 2010 18:00:26 +0800
Subject: [PATCH 0/2] Add GPIO WP and HW bus-width caps when support i.MX51 BBG
	board
Message-ID: <1287568828-22563-1-git-send-email-r65037@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serial patches are based on Wolfram and Eric's eSDHC driver patchs, and
add the GPIO Write Protection, and HW bus-width cpas supports on i.MX51
BBG boards.

[PATCH 1/2] Add the GPIO Write Protection Solution on i.MX51 BBG board
arch/arm/mach-mx5/board-mx51_babbage.c      |   16 ++++++++++++++--
arch/arm/plat-mxc/include/mach/iomux-mx51.h |    8 +++++---
2 files changed, 19 insertions(+), 5 deletions(-)

[PATCH 2/2] Add the HW board caps flag for MX51 BBG
arch/arm/mach-mx5/board-mx51_babbage.c |    3 +++
arch/arm/plat-mxc/include/mach/esdhc.h |    1 +
drivers/mmc/host/sdhci-esdhc-imx.c     |    1 +
drivers/mmc/host/sdhci.c               |    8 ++++++--
4 files changed, 11 insertions(+), 2 deletions(-)
