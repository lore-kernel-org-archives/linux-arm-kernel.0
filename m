From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:35:55 +0200
Subject: [PATCH 0/9] ARM: tegra: collection of enhancements/fixes
Message-ID: <cover.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This series is a set of patches accumulated over Easter ultimately
bringing HDA audio to Tegra30 devices.

Marcel Ziswiler (9):
  ARM: tegra: Cardhu device-tree comment spelling fix
  ARM: tegra: fix hda2codec_2x clock name for Tegra30
  Documentation: DT bindings: fix hda2codec_2x clock name for
    tegra30-hda
  ARM: tegra: add Tegra30 HDA support
  ARM: tegra: fix hda2codec_2x clock name in Tegra124 device tree
  ARM: tegra: enable watchdog in defconfig
  ARM: tegra: enable HDA in defconfig
  ARM: tegra: colibri t30: activate stmpe811 touch controller
  ARM: tegra: apalis t30: fix pin muxing and add HDA in device tree

 .../bindings/sound/nvidia,tegra30-hda.txt          |  8 ++--
 arch/arm/boot/dts/tegra124.dtsi                    |  4 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |  5 +++
 arch/arm/boot/dts/tegra30-apalis.dtsi              | 46 ++++++++++++++++------
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |  2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |  4 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi             | 44 ++++++++++++++++++++-
 arch/arm/boot/dts/tegra30.dtsi                     | 15 +++++++
 arch/arm/configs/tegra_defconfig                   | 10 +++++
 drivers/clk/tegra/clk-tegra30.c                    |  2 +-
 10 files changed, 117 insertions(+), 23 deletions(-)

-- 
1.9.3
