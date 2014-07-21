From: marek@goldelico.com (Marek Belisko)
Date: Mon, 21 Jul 2014 23:05:20 +0200
Subject: [PATCH 0/7] arm: dts: oma3-gta04: Various updates
Message-ID: <1405976727-15166-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following patchset add various improvements to gta04 devicetree.

Marek Belisko (7):
  arm: dts: omap3-gta04: Add nand support
  arm: dts: omap3-gta04: Fix magnetometer model
  arm: dts: omap3-gta04: Add wifi reset node
  arm: dts: omap3-gta04: Move spi gpio pins to pmx_core2
  arm: dts: omap3-gta04: Add USB host support
  arm: dts: omap3-gta04: Add display alias
  arm: dts: omap3-gta04: Add twl4030 regulators parameters

 arch/arm/boot/dts/omap3-gta04.dts | 150 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 5 deletions(-)

-- 
1.9.1
