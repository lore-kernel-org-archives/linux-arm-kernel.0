From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 16:59:24 +0100
Subject: [PATCH 00/10] ARM: tegra: DSI and panel support
Message-ID: <1387468774-14216-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches add support for Tegra114 display, DSI, HDMI, gr2d
and gr3d. Both DSI and HDMI outputs are enabled on Dalmore.

The LVDS panels on Harmony and Cardhu are added to the corresponding DTS
files and support for panels is enabled in the Tegra defconfig.

Thierry

Mikko Perttunen (2):
  ARM: tegra: Add host1x, DC and HDMI to Tegra114 device tree
  ARM: tegra: Enable HDMI support on Dalmore

Thierry Reding (8):
  ARM: tegra: Enable LVDS on Harmony
  ARM: tegra: Enable LVDS on Cardhu
  ARM: tegra: Add MIPI calibration DT entries for Tegra114
  ARM: tegra: Add Tegra114 DSI support
  ARM: tegra: Add Tegra114 gr2d support
  ARM: tegra: Add Tegra114 gr3d support
  ARM: tegra: Enable DSI support on Dalmore
  ARM: tegra: Enable DRM panel support

 arch/arm/boot/dts/tegra114-dalmore.dts |  59 +++++++++++++----
 arch/arm/boot/dts/tegra114.dtsi        | 113 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20-harmony.dts  |  36 ++++++++++-
 arch/arm/boot/dts/tegra30-cardhu.dtsi  |  37 ++++++++++-
 arch/arm/configs/tegra_defconfig       |   2 +
 5 files changed, 232 insertions(+), 15 deletions(-)

-- 
1.8.4.2
