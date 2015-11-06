From: tharvey@gateworks.com (Tim Harvey)
Date: Fri,  6 Nov 2015 14:40:29 -0800
Subject: [PATCH 0/3] ARM: dts: imx: ventana LVDS fixes
Message-ID: <1446849632-20333-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series has a vew device-tree patches that resolves some LVDS issues
with Gateworks Ventana boards.

Tim Harvey (3):
  ARM: dts: imx: ventana: set GW54xx PMIC swbst regulator as always-on
  ARM: dts: imx: ventana: fix GW53xx/GW54xx lvds channel
  ARM: dts: imx: ventana: Allow HDMI and LVDS to work simultaneously

 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi |  7 +++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi |  9 ++++++++-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 11 ++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

-- 
1.9.1
