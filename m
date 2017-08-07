From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  7 Aug 2017 12:52:32 +0530
Subject: [PATCH 00/10] Add support for Ixora V1.1 and Apalis Evaluation Board
Message-ID: <cover.1502087184.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for Toradex Ixora V1.1 and Apalis
Evaluation Board along with some cleanups.

Patch series has been generated on top of shawn's for-next branch.

Regards,
Sanchayan.

Marcel Ziswiler (6):
  ARM: dts: imx6q-apalis-ixora: combine aliases
  ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: get rid of tegra legacy gen1_i2c comment
  ARM: dts: imx6qdl-apalis: reword cam i2c comment
  ARM: dts: imx6q-apalis-ixora: get rid of obsolete fusion comment
  ARM: dts: imx6q-apalis-ixora: add camera i2c bus definition
  ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: use i2c from dwc hdmi

Sanchayan Maity (4):
  ARM: dts: imx6q-apalis-ixora: fix usdhc2 pinctrl property
  ARM: dts: imx6qdl-apalis: split usdhc1 pinctrl to support 4- and 8-bit
  ARM: dts: imx6: add support for Toradex Ixora V1.1 carrier board
  ARM: dts: imx6q-apalis-eval: add support for Apalis Evaluation Board

 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 278 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 291 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      |  32 ++-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         |  44 ++--
 5 files changed, 605 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-eval.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts

-- 
2.13.3
