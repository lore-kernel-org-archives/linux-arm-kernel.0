From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 14 Oct 2018 14:34:42 +0000
Subject: [PATCH V2 0/4] arm64: imx: add imx8qxp support
Message-ID: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp mek basic support with the function
Lpuart
uSDHC
FEC
GPIO

Note it depends on the clock and pinctrl driver parts.

Dong Aisheng (4):
  arm64: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp mek support
  defconfig: arm64: add imx8qxp support

 Documentation/devicetree/bindings/arm/fsl.txt |   8 +
 arch/arm64/Kconfig.platforms                  |  22 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi  |  61 ++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 134 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 861 ++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                  |   6 +
 7 files changed, 1093 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi

-- 
2.7.4
