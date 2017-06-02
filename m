From: stefan@agner.ch (Stefan Agner)
Date: Thu,  1 Jun 2017 19:11:08 -0700
Subject: [PATCH v4 0/2] ARM: dts: imx7: add NAND support
Message-ID: <cover.9cbefd91387aefe2522dbb3e6338e4e4efdb5e41.1496369342.git-series.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This are the missing device tree parts to add NAND support for i.MX 7.
See previous patchset:
https://lkml.org/lkml/2017/4/21/832

The previous version also included driver changes, which are already
merged.

--
Stefan

Changes since v3:
- Only specify IMX7D_NAND_USDHC_BUS_ROOT_CLK which seems to be sufficent

Changes since v2:
- Dropped driver changes, alreay merged

Changes since v1:
- Make clks_count const
- Introduce IS_IMX7D for i.MX 7 SoC's and make it part of GPMI_IS_MX6

Stefan Agner (2):
  ARM: dts: imx7: add GPMI NAND
  ARM: dts: imx7-colibri: add NAND support

 arch/arm/boot/dts/imx7-colibri.dtsi |  9 +++++++++-
 arch/arm/boot/dts/imx7s.dtsi        | 30 ++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+)

base-commit: e2bb3be2c6c623ff0bad975dc9435531f450f0c5
-- 
git-series 0.9.1
