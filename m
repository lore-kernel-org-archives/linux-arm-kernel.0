From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 8 Mar 2013 19:22:57 +0530
Subject: [PATCH 0/5] ARM: DT: tegra114: Add DT entry for different controller
Message-ID: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add DT entry for APB DMA, I2C, UART, KBC and SPI.

This patch series is generated on top of CCF work for T114 done by Peter
and hence it should be applied on top of T114 CCF patches.

Laxman Dewangan (5):
  ARM: DT: tegra114: add APB DMA controller DT entry
  ARM: DT: tegra114: Add i2c controller DT entry
  ARM: DT: tegra114:add aliases and DMA requestor for serial controller
  ARM: DT: tegra114: add KBC controller DT entry
  ARM: DT: tegra114: Add spi controller DT entry

 arch/arm/boot/dts/tegra114.dtsi |  202 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 197 insertions(+), 5 deletions(-)
