From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 16:50:09 +0200
Subject: [PATCH 0/6] ARM: dts: imx27 Phytec PhyCARD-S
Message-ID: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds some device nodes for imx27 and a board file for Phytec
PhyCARD-S. It is based on shawn's branch "imx/dt".

Regards,

Markus


Fabio Estevam (2):
      ARM: mx27: Replace clk_register_clkdev with clock DT lookup
      ARM: imx27: Use 'AITC' for the interrupt controller name

Markus Pargmann (4):
      ARM: dts: imx27: Add imx framebuffer device
      ARM: dts: imx27: Add 1-wire
      ARM: dts: imx27 cpufreq-cpu0 frequencies
      ARM: dts: Add device tree support for phycard pca100

 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/imx27-phytec-phycard-S.dts | 195 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi                 |  54 +++++++-
 arch/arm/mach-imx/Kconfig                    |   1 +
 4 files changed, 248 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycard-S.dts
