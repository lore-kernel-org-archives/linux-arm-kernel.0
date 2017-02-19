From: plaes@plaes.org (Priit Laes)
Date: Sun, 19 Feb 2017 22:27:57 +0200
Subject: [PATCH 0/4] ARM: dts: Add Parvus Duracor C310 board support
Message-ID: <20170219202801.2082-1-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic devicetree files for Parvus Duracor C310 which is a custom
carrier with MXM3 connector for SMARC module.

SMARC module used in C310 is manufactured by Kontron AG.


Priit Laes (4):
  arm: defconfig: imx6: Added CONFIG_FHANDLE
  devicetree: Add vendor prefix for Kontron AG
  arm: dts: imx: Add iMX6Q-based Kontron SMARC-sAMX6i module
  arm: dts: imx: Basic board definition for Parvus Duracor C310

 .../devicetree/bindings/vendor-prefixes.txt        |   3 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx6q-parvus-duracor-310.dts     | 119 ++++++
 arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi          | 434 +++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 5 files changed, 557 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6q-parvus-duracor-310.dts
 create mode 100644 arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi

-- 
2.9.3
