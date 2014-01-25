From: marek@goldelico.com (Marek Belisko)
Date: Sat, 25 Jan 2014 22:28:54 +0100
Subject: [PATCH 0/9] ARM: dts: omap3-gta04: Various devicetree updates.
Message-ID: <1390685343-11663-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pathes fix some wrong property issues and add some new devices to
devicetree. This was tested on linux-next (next-20140124).

Marek Belisko (6):
  ARM: dts: omap3-gta04: Fix mmc1 properties.
  ARM: dts: omap3-gta04: Add basic sound support.
  ARM: dts: omap3-gta04: Add twl4030 charger.
  ARM: dts: omap3-gta04: Add touchscreen properties.
  ARM: dts: omap3-gta04: Add support for magnetometer.
  ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid
    problems with booting.

NeilBrown (3):
  ARM: dts: omap3-gta04: Fix 'aux' gpio key flags.
  ARM: dts: omap3-gta04: Add bma180 accelerometer.
  ARM: dts: omap3-gta04: Enable mmc2 for wifi.

 arch/arm/boot/dts/omap3-gta04.dts | 58 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

-- 
1.8.3.2
