From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 13 Nov 2012 10:33:38 +0530
Subject: [PATCH 0/3] ARM: tegra: dt: Add entry for tegra20 sflash controller.
Message-ID: <1352783021-25393-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add the dt entry for tegra20 sflash controller,
add AUXDATA in board dt file for driver name and enable in tegra_defconfig.

Laxman Dewangan (3):
  ARM: tegra: dts: add sflash controller dt entry
  ARM: tegra: Add OF_DEV_AUXDATA for sflash driver in board dt
  ARM: config: tegra: enable SFLASH controller driver

 arch/arm/boot/dts/tegra20.dtsi         |   10 ++++++++++
 arch/arm/configs/tegra_defconfig       |    1 +
 arch/arm/mach-tegra/board-dt-tegra20.c |    2 ++
 3 files changed, 13 insertions(+), 0 deletions(-)
