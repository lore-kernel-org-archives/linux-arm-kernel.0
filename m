From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 16 Nov 2012 16:56:49 +0100
Subject: [PATCH 0/3] ARM: tegra: Enable HDMI on Tamonten carriers
Message-ID: <1353081412-19448-1-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three patches in this series enable the HDMI output on Plutux and
TEC. The Medcom-Wide only has an LVDS output and the TEC has an LVDS
output as well, but since they depend on the videomode helpers and the
power-sequences patch series, they will only be enabled in subsequent
patches.

Thierry

Thierry Reding (3):
  ARM: tegra: tamonten: Add host1x support
  ARM: tegra: plutux: Enable HDMI output
  ARM: tegra: tec: Enable HDMI output

 arch/arm/boot/dts/tegra20-plutux.dts    |  6 ++++++
 arch/arm/boot/dts/tegra20-tamonten.dtsi | 16 +++++++++++++---
 arch/arm/boot/dts/tegra20-tec.dts       |  6 ++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
1.8.0
