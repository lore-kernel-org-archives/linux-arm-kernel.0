From: marek@goldelico.com (Marek Belisko)
Date: Tue, 17 May 2016 21:48:46 +0200
Subject: [PATCH 0/5] ARM: dts: omap3-gta04: Various updates
Message-ID: <1463514531-7235-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add various improvements for gta04 device (wifi, backlight, irq lines for sensors)

H. Nikolaus Schaller (4):
  ARM: dts: omap3-gta04: Define and use bma180 irq pin
  ARM: dta: omap3-gta04: Define and use itg3200  irq pin
  ARM: dta: omap3-gta04: Define and use hmc5843 irq pin
  ARM: dts: omap3-gat04: Fix wifi handling

Marek Belisko (1):
  ARM: dts: omap3-gta04: Add backlight support

 arch/arm/boot/dts/omap3-gta04.dtsi | 60 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

-- 
2.5.0
