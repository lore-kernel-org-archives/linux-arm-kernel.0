From: ralf@ramses-pyramidenbau.de (Ralf Ramsauer)
Date: Tue, 26 Jan 2016 17:59:16 +0100
Subject: [PATCH v2 0/2] ARM: tegra: Enable high speed UARTs of the Jetson TK1
Message-ID: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

this one enables the high speed UARTs of the Jetson TK1 (and corrects
a not noteworthy typo). Those additional UARTs are exposed on the
expansion connector of the TK1.

So far, they were only enabled in NVidia's official BSP.

  Ralf

Ralf Ramsauer (2):
  ARM: tegra: Fixed typo
  ARM: tegra: Add high speed UARTs to Jetson TK1 device tree

 arch/arm/boot/dts/tegra114.dtsi           |  2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra124.dtsi           |  2 +-
 arch/arm/boot/dts/tegra20.dtsi            |  2 +-
 arch/arm/boot/dts/tegra30.dtsi            |  2 +-
 5 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.4.10
