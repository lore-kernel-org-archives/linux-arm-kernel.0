From: satish.patel@ti.com (Satish Patel)
Date: Mon, 6 Jan 2014 17:42:29 +0530
Subject: [RFC PATCH v1 0/2] clock and HWMOD changes for USIM module
Message-ID: <1389010351-17320-1-git-send-email-satish.patel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch set includes clock and HWMOD entries for AM43x's USIM modoule.

Note: I am in process of mainlining usim driver.

Satish Patel (2):
  ARM: dts: AM43xx-clocks: Entries added for ti-usim
  ARM: OMAP: AM43xx: HWMOD changes added for ti-usim

 arch/arm/boot/dts/am43xx-clocks.dtsi       |   34 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   39 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 drivers/clk/ti/clk-43xx.c                  |    4 +++
 4 files changed, 78 insertions(+), 0 deletions(-)
