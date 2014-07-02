From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 2 Jul 2014 17:02:47 +0800
Subject: [PATCH 0/5] ARM: imx: Add Freescale LS1021A SoC and board support 
Message-ID: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contain the support for Freescale LS1021A CPU and LS1021A-QDS
and LS1021A-TWR board.

The LS1021A SoC combines two ARM Cortex-A7 cores that have been optimized
for high reliability and pack the highest level of integration available
for sub-3 W embedded communications processors and with a comprehensive
enablement model focused on ease of programmability.

The LS1021A SoC shares IPs with i.MX family, Vybrid family and Freescale
PowerPC platform. 

For the detail information about LS1021A SoC, please refer to the RM doc.

----------------------------------------------------------------
Jingchang Lu (5):
	ARM: dts: Add SoC level device tree support for LS1021A
	ARM: dts: Add initial LS1021A QDS board dts support
	ARM: dts: Add initial LS1021A TWR board dts support
	ARM: imx: Add initial support for Freescale LS1021A
	ARM: imx: Add Freescale LS1021A SMP support

 arch/arm/boot/dts/Makefile        |   4 +-
 arch/arm/boot/dts/ls1021a-qds.dts | 380 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/ls1021a-twr.dts | 236 +++++++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi    | 852 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig         |  17 ++
 arch/arm/mach-imx/Makefile        |   2 +
 arch/arm/mach-imx/common.h        |   2 +
 arch/arm/mach-imx/headsmp.S       |  11 +
 arch/arm/mach-imx/mach-ls1021a.c  |  50 ++++
 arch/arm/mach-imx/platsmp.c       |  44 ++++
 10 files changed, 1597 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/ls1021a-qds.dts
 create mode 100755 arch/arm/boot/dts/ls1021a-twr.dts
 create mode 100644 arch/arm/boot/dts/ls1021a.dtsi
 create mode 100644 arch/arm/mach-imx/mach-ls1021a.c
