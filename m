From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 24 Apr 2014 15:07:24 -0700
Subject: [PATCH 0/3] ARM: dts: imx: various fixes for LVDS on Ventana
Message-ID: <1398377247-3901-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the LVDS display on GW54xx/GW53xx/GW52xx.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Tim Harvey (3):
  ARM: dts: imx: Fix LVDS mapping for Ventana GW53xx/GW54xx
  ARM: dts: imx: add LVDS backlight for Ventana
  ARM: dts: imx: Fix LVDS mapping for Ventana GW52xx

 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 40 ++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 22 ++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 22 ++++++++++++++++++-
 3 files changed, 81 insertions(+), 3 deletions(-)

-- 
1.8.3.2
