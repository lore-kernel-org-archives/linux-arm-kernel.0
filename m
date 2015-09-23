From: plaes@plaes.org (Priit Laes)
Date: Wed, 23 Sep 2015 10:38:30 +0300
Subject: [PATCH v2 0/4] ARM: dts: sun4i: gemei-g9: Devicetree improvements
Message-ID: <1442993914-20295-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improvements to devicetree setup:
 - Added IRQ configuration for bma250 accelerometer
 - Converted to use axp209 regulator nodes
 - Fix invalid regulator for LRADC keys
 - Enabled audio codec

Changes since v1:
 - Dropped NAND patch because driver is not yet ready
 - Dropped applied KEYBOARD_SUN4I_LRADC patch
 - Added sun4i audio codec patch

Priit Laes (4):
  ARM: dts: sun4i: gemei-g9: Add accelerometer (bma250) IRQ
  ARM: dts: sun4i: gemei-g9: Convert to use axp209 regulator nodes
  ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of reg_vcc3v0
  ARM: dts: sun4i: gemei-g9: Enable sun4i audio codec support

 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 59 +++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 12 deletions(-)

-- 
2.5.3
