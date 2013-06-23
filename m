From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 23 Jun 2013 10:44:16 +0200
Subject: [PATCH v2 0/5] ARM: dts: imx27 Phytec PhyCARD-S
Message-ID: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds some device nodes for imx27 and board files for Phytec
PhyCARD-S SOM and RDK. It is based on shawn's branch "imx/dt".

Regards,

Markus

Changes in v2:
 - Removed already accepted clocks patch
   "ARM: mx27: Replace clk_register_clkdev with clock DT lookup"
 - pca100 board file was splitted into two parts SOM and RDK
 - other changes described in patch notes

Fabio Estevam (1):
      ARM: imx27: Use 'AITC' for the interrupt controller name

Markus Pargmann (4):
      ARM: dts: imx27: Add imx framebuffer device
      ARM: dts: imx27: Add 1-wire
      ARM: dts: imx27 cpufreq-cpu0 frequencies
      ARM: dts: Add device tree support for phycard pca100

 arch/arm/boot/dts/Makefile                       |  2 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 62 ++++++++++++++++++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 72 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi                     | 41 +++++++++++++-
 4 files changed, 174 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
