From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Fri, 8 Jul 2016 18:15:39 +0800
Subject: [PATCH 0/5] arm64: dts: add QorIQ LS1046A SoC and boards support
Message-ID: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

This patchest adds support for QorIQ LS1046A SoC which is based on ARMv8
architecture, also adds LS1046A-RDB and LS1046A-QDS board support.

Mingkai Hu (2):
  arm64: dts: add QorIQ LS1046A SoC support
  arm64: dts: add LS1046A-RDB board support

Shaohui Xie (3):
  Documentation: DT: Add entry for QorIQ LS1046A-RDB board
  Documentation: DT: Add entry for QorIQ LS1046A-QDS board
  arm64: dts: add LS1046A-QDS board support

 Documentation/devicetree/bindings/arm/fsl.txt     |   8 +
 arch/arm64/boot/dts/freescale/Makefile            |   2 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 209 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 138 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    | 549 ++++++++++++++++++++++
 5 files changed, 906 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi

-- 
2.1.0.27.g96db324
