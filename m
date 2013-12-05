From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 5 Dec 2013 16:27:46 +0530
Subject: [PATCH 0/4] pinctrl: tegra: Add pincontrol driver for Tegra124 SoC
Message-ID: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pincontrol driver for NVIDIA's Tegra124 SoCs.
This series add pincontrol driver which contains the pinmux tables
for tegra124, pincontrol dt binding doc, dtsi file change for adding
pinmux node, selecting pincontrol config for Tegra124.

Ashwini Ghuge (1):
  pinctrl: tegra: add pinmux controller driver for Tegra124

Laxman Dewangan (3):
  pinctrl: tegra: Add devicetree binding document for Tegra124
  ARM: tegra: add pinmux controller to tegra124.dtsi
  ARM: tegra: select PINCTRL_TEGRA124 for Tegra124 SoC

 .../bindings/pinctrl/nvidia,tegra124-pinmux.txt    |  137 +
 arch/arm/boot/dts/tegra124.dtsi                    |    6 +
 arch/arm/mach-tegra/Kconfig                        |    1 +
 drivers/pinctrl/Kconfig                            |    4 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-tegra124.c                 | 3147 ++++++++++++++++++++
 6 files changed, 3296 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
 create mode 100644 drivers/pinctrl/pinctrl-tegra124.c
