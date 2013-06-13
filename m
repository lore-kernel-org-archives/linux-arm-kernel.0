From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 13 Jun 2013 19:50:55 +0800
Subject: [PATCH 0/9] Update imx6qdl dts/dtsi to support WM8962
Message-ID: <cover.1371123426.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*** This branch of patches add WM8962 support in imx6q/dl-sabresd dts.

Nicolin Chen (9):
  ARM: clk-imx6qdl: Add clko1 configuration for imx6qdl-sabresd
  ARM: dts: imx6qdl-sabresd: add clko1 iomux configuration
  ARM: dtsi: imx6q/imx6dl: Add a pinctrl for I2C1
  ARM: dtsi: imx6dl: Add a pinctrl for AUDMUX
  ARM: dtsi: imx6qdl-sabresd: add a fixed regulator for WM8962
  ARM: dtsi: imx6qdl-sabresd: Add WM8962 CODEC support
  ARM: dtsi: imx6qdl-sabresd: Enable SSI2 and AUDMUX
  ARM: dtsi: imx6qdl-sabresd: Enable WM8962 audio support
  ARM: imx_v6_v7_defconfig: Enable imx-wm8962 by default

 arch/arm/boot/dts/imx6dl-sabresd.dts   |    1 +
 arch/arm/boot/dts/imx6dl.dtsi          |   20 ++++++++++
 arch/arm/boot/dts/imx6q-sabresd.dts    |    1 +
 arch/arm/boot/dts/imx6q.dtsi           |    7 +++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   66 ++++++++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig   |    2 +
 arch/arm/mach-imx/clk-imx6q.c          |    2 +
 arch/arm/mach-imx/mach-imx6q.c         |   42 ++++++++++++++++++++
 8 files changed, 141 insertions(+), 0 deletions(-)
