From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:06 +0100
Subject: [PATCH 00/13] ARM: dts: omap3-gta04: Various DT fixes
Message-ID: <1421959099-28319-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains fixes for gta04 devicetree. I collected patches
from H. Nikolaus Schaller + NeilBrown and myself. Patches contains mostly fixes
+ adding new nodes and comments. All changes tested on gta04a4 board.

H. Nikolaus Schaller (5):
  ARM: dts: omap3-gta04: Fix backup-battery charging in devicetree file.
  ARM: dts: omap3-gta04: Fix audio node malformatting
  ARM: dts: omap3-gta04: Enable mcbps2 necessary for audio
  ARM: dts: omap3-gta04: Enable twl audio vibra support
  ARM: dts: omap3-gta04: Enable power-off using twl4030

Marek Belisko (2):
  ARM: dts: omap3-gta04: Fix a GPIO line for bma180 node
  ARM: dts: omap3-gta04: Add ramp value for twl4030 audio

NeilBrown (6):
  ARM: dts: omap3-gta04: add comments about gpios
  ARM: dts: omap3-gta04: enable power-off for wifi card.
  ARM: dts: omap3-gta04: add gyroscope
  ARM: dts: omap3-gta04: only power DSS when necessary.
  ARM: dts: omap3-gta04: uart4 is not connected, so mark it "disabled"
  ARM: dts: omap3-gta04: Disable keypad

 arch/arm/boot/dts/omap3-gta04.dtsi | 54 +++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 15 deletions(-)

-- 
1.9.1
