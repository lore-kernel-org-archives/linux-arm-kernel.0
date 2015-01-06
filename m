From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue,  6 Jan 2015 11:37:25 +0100
Subject: [PATCH 0/4] Add support for nyan-blaze
Message-ID: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the nyan-blaze board is the HP Chromebook 14. This series reuses the DTS that we currently have for nyan-big and also contains two fixes needed to get it to feature parity.

Cheers,

Tomeu

Tomeu Vizoso (4):
  ARM: tegra: rely on bootloader pinmux programming on nyan-big
  ARM: tegra: Move out nyan-generic parts out from the nyan-big DT
  ARM: tegra: Add DTS for the nyan-blaze board
  ARM: tegra: remove wp-gpios from the generic nyan dtsi

 arch/arm/boot/dts/Makefile                |    1 +
 arch/arm/boot/dts/tegra124-nyan-big.dts   | 1127 +---------------------------
 arch/arm/boot/dts/tegra124-nyan-blaze.dts |   12 +
 arch/arm/boot/dts/tegra124-nyan.dtsi      | 1132 +++++++++++++++++++++++++++++
 4 files changed, 1148 insertions(+), 1124 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-blaze.dts
 create mode 100644 arch/arm/boot/dts/tegra124-nyan.dtsi

-- 
1.9.3
