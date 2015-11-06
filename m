From: plaes@plaes.org (Priit Laes)
Date: Fri,  6 Nov 2015 19:54:43 +0200
Subject: [PATCH v3 0/3] ARM: dts: sun4i: gemei-g9: Devicetree improvements
Message-ID: <1446832486-32319-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improvements to devicetree setup:
 - Converted to use axp209 regulator nodes
 - Fix invalid regulator for LRADC keys
 - Enable audio codec node

Changes sinve v2:
 - Dropped applied "Added IRQ configuration for bma250 accelerometer" patch

Changes since v1:
 - Dropped NAND patch because driver is not yet ready
 - Dropped applied KEYBOARD_SUN4I_LRADC patch
 - Added sun4i audio codec patch


Priit Laes (3):
  ARM: dts: sun4i: gemei-g9: Convert to use axp209 regulator nodes
  ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of reg_vcc3v0
  ARM: dts: sun4i: gemei-g9: Enable sun4i audio codec support

 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 42 +++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

-- 
2.6.3
