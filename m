From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat, 10 Feb 2018 02:36:35 +0100
Subject: [PATCH 0/3] ARM: dts: tegra: apalis/colibri updates
Message-ID: <20180210013638.28164-1-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series fixes the I2C bus frequencies, uses the correct compatible
for the RTC and removes an unneeded reg property for Tegra based
Toradex Apalis and Colibri modules.


Marcel Ziswiler (3):
  apalis_t30/tk1, colibri_t20/t30: fix i2c bus frequencies
  ARM: dts: tegra: apalis/colibri: use correct compatible for rtc
  ARM: dts: tegra: apalis/colibri: remove unneeded reg property

 arch/arm/boot/dts/tegra124-apalis-eval.dts    |  7 +++----
 arch/arm/boot/dts/tegra124-apalis.dtsi        |  2 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi    | 16 +++++++++++-----
 arch/arm/boot/dts/tegra30-apalis-eval.dts     |  4 ++--
 arch/arm/boot/dts/tegra30-apalis.dtsi         |  3 +--
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  4 ++--
 arch/arm/boot/dts/tegra30-colibri.dtsi        |  3 +--
 7 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.14.3
