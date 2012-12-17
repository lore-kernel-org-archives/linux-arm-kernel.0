From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 17 Dec 2012 17:38:17 +0530
Subject: [PATCH 0/4] ARM: tegra: add support for highspeed serial driver
Message-ID: <1355746101-15291-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add the infrastruture for supporting
highspeed serial driver for Nvidia's Tegra SOCs.

Laxman Dewangan (4):
  ARM: tegra30: Add support for Uart clock source divider as 15.1
  ARM: tegra: add connection name for uart clock table
  ARM: tegra: Add OF_DEV_AUXDATA for uart driver in board dt
  ARM: tegra: dts: add dma requestor and port numbers for serial
    controller

 arch/arm/boot/dts/tegra20.dtsi            |   10 ++++
 arch/arm/boot/dts/tegra30.dtsi            |   10 ++++
 arch/arm/mach-tegra/board-dt-tegra20.c    |    8 +++
 arch/arm/mach-tegra/board-dt-tegra30.c    |    9 ++++
 arch/arm/mach-tegra/clock.h               |    3 +-
 arch/arm/mach-tegra/tegra20_clocks_data.c |   12 +++---
 arch/arm/mach-tegra/tegra30_clocks.c      |   70 ++++++++++++++++++++++------
 arch/arm/mach-tegra/tegra30_clocks_data.c |   10 ++--
 8 files changed, 105 insertions(+), 27 deletions(-)
