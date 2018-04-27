From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 03:06:12 +0800
Subject: [PATCH 0/5] arm64: imx: add imx8qxp support
Message-ID: <1524855977-15719-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp support

Dong Aisheng (5):
  soc: imx: add imx8 soc device support
  arm64: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp support
  defconfig: arm64: add imx8qxp support
  MAINTAINERS: imx: add NXP linux team upstream maillist as reviewer

 Documentation/devicetree/bindings/arm/fsl.txt     |   5 +
 MAINTAINERS                                       |   1 +
 arch/arm64/Kconfig.platforms                      |  23 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-imx8-ca35.dtsi  |  66 ++
 arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts | 138 ++++
 arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi    | 794 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                      |   6 +
 drivers/soc/imx/Kconfig                           |   4 +
 drivers/soc/imx/Makefile                          |   1 +
 drivers/soc/imx/soc-imx8.c                        | 106 +++
 include/dt-bindings/power/imx-rsrc.h              | 558 +++++++++++++++
 12 files changed, 1703 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-imx8-ca35.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-imx8qxp.dtsi
 create mode 100644 drivers/soc/imx/soc-imx8.c
 create mode 100644 include/dt-bindings/power/imx-rsrc.h

-- 
2.7.4
