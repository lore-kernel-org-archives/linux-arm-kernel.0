From: tony@atomide.com (Tony Lindgren)
Date: Fri,  1 May 2015 18:05:50 -0700
Subject: [PATCH 0/2] Minimal dts support for LogicPD Torpedo SOM devkit
Message-ID: <1430528752-316-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This seems to be the last missing omap3 dts file, so far we've only
had minimal board-*.c legacy support for it.

Here's some more info about this board:

http://www.logicpd.com/products/system-on-modules/dm3730-torpedo-wireless-som/
http://www.logicpd.com/products/system-on-modules/zoom-dm3730-torpedo/

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP3: Add support for configuring MMC pins as GPIO pins
  ARM: dts: Add minimal support for LogicPD Torpedo DM3730 devkit

 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 157 +++++++++++++++++++++
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi        | 162 ++++++++++++++++++++++
 arch/arm/mach-omap2/control.c                     |   3 +
 arch/arm/mach-omap2/control.h                     |   3 +
 arch/arm/mach-omap2/pdata-quirks.c                |  22 +++
 6 files changed, 348 insertions(+)
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-som.dtsi

-- 
2.1.4
