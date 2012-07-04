From: wni@nvidia.com (Wei Ni)
Date: Wed, 4 Jul 2012 17:34:43 +0800
Subject: [PATCH 0/5] ARM: tegra: enable wlan for t20 and t30
Message-ID: <1341394488-13169-1-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set up clocks, pinmux, gpios and configs to enable wlan for
following tegra boards:
Tegra30: Cardhu.
Tegra20: Seaboard, Ventana.

Wei Ni (5):
  ARM: tegra: set up wlan clocks for tegra dt
  ARM: dt: t20 seaboard: add pinmux, gpio for wlan
  ARM: dt: t20 ventana: add pinmux, gpio for wlan
  ARM: dt: t30 cardhu: add pinmux, gpio for wlan
  ARM: tegra: enable wireless in defconfig

 arch/arm/boot/dts/tegra20-seaboard.dts |    5 +++++
 arch/arm/boot/dts/tegra20-ventana.dts  |   20 ++++++++++++++++++--
 arch/arm/boot/dts/tegra30-cardhu.dts   |   30 ++++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig       |    6 ++++--
 arch/arm/mach-tegra/board-dt-tegra20.c |    1 +
 arch/arm/mach-tegra/board-dt-tegra30.c |    1 +
 6 files changed, 59 insertions(+), 4 deletions(-)
