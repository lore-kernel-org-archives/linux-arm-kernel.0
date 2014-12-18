From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Thu, 18 Dec 2014 21:54:09 +0530
Subject: [PATCH 0/5] ARM: am43xx: enable VPFE
Message-ID: <1418919854-16164-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Parrot <bparrot@ti.com>

This patch series adds hwmods and VPFE DT node entries
for am43xx devices.
The sensor driver is not allowed to release so the remote
endpoint for vpfe dt nodes are commented at the moment.

Benoit Parrot (4):
  ARM: AM43xx: hwmod: add VPFE hwmod entries
  ARM: dts: am4372: add VPFE DT node entries
  ARM: dts: am43x-epos-evm: add VPFE device tree data
  ARM: dts: am437x-gp-evm: add VPFE device tree data

Darren Etheridge (1):
  ARM: dts: am437x-sk-evm: add VPFE device tree data

 arch/arm/boot/dts/am4372.dtsi              |  16 +++++
 arch/arm/boot/dts/am437x-gp-evm.dts        | 106 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts        |  58 ++++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts       |  53 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  56 +++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |   3 +-
 6 files changed, 291 insertions(+), 1 deletion(-)

-- 
1.9.1
