From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Mon, 5 Sep 2016 18:01:28 +0800
Subject: [PATCH 0/7] [v2] arm64: dts: add QorIQ LS1046A SoC and boards support
Message-ID: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

This patchest adds support for QorIQ LS1046A SoC which is based on ARMv8
architecture, also adds LS1046A-RDB and LS1046A-QDS board support.

Also, updates bindings for SoC-specific devices SCFG and DCFG,
and I2C devices.

Mingkai Hu (2):
  arm64: dts: add QorIQ LS1046A SoC support
  arm64: dts: add LS1046A-RDB board support

Shaohui Xie (5):
  dt-bindings: fsl: updates bindings for some SoC-specific devices
  dt-bindings: i2c: adds two more nxp devices
  Documentation: DT: Add entry for QorIQ LS1046A-RDB board
  Documentation: DT: Add entry for QorIQ LS1046A-QDS board
  arm64: dts: add LS1046A-QDS board support

 Documentation/devicetree/bindings/arm/fsl.txt      |  20 +-
 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   2 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 212 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 150 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 511 +++++++++++++++++++++
 6 files changed, 894 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi

-- 
2.1.0.27.g96db324
