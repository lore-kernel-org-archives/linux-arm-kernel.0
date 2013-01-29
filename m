From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 29 Jan 2013 18:26:16 +0530
Subject: [PATCH 0/7] ARM: DT: tegra114: add dt entry for
 gpio/pinmux/dma/i2c/serial/kbc
Message-ID: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add DT entry for the NVIDIA's Tegra114 SoCs for the following
controller:
- GPIO controller
- DMA controller.
- Pinmux controller.
- I2c controller.
- KBC controler.

Also add dma requestor and aliases for serial channel.

Laxman Dewangan (7):
  ARM: tegra114: select PINCTRL for Tegra114 SoC
  ARM: DT: tegra114: add GPIO DT entry
  ARM: DT: tegra114: add APB DMA controller DT entry
  ARM: DT: tegra114: add pinmux DT entry
  ARM: DT: tegra114: Add i2c controller DT entry
  ARM: DT: tegra114:add aliases and DMA requestor for serial controller
  ARM: DT: tegra114: add KBC controller DT entry

 arch/arm/boot/dts/tegra114.dtsi |  139 +++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/Kconfig     |    2 +
 2 files changed, 137 insertions(+), 4 deletions(-)
