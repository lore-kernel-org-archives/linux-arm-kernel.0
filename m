From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 18:19:09 +0000
Subject: [PATCH V3 0/8] arm64: imx: add imx8qxp support
Message-ID: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp mek basic support with the function
Lpuart
uSDHC
FEC
GPIO

Dong Aisheng (8):
  arm64: imx: add imx8qxp support
  dt-bindings: serial: lpuart: add imx8qxp compatible string
  dt-bindings: mmc: fsl-imx-esdhc: add imx8qxp compatible string
  dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp compatible string
  dt-bindings: spi: lpspi: add imx8qxp compatible string
  arm64: dts: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp mek support
  defconfig: arm64: add imx8qxp support

 Documentation/devicetree/bindings/arm/fsl.txt      |   8 +
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt      |   1 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   1 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   2 +
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      |   1 +
 arch/arm64/Kconfig.platforms                       |  22 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi       |  61 ++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      | 141 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         | 870 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   6 +
 11 files changed, 1114 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi

-- 
2.7.4
