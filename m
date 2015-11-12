From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 12 Nov 2015 15:07:25 +0100
Subject: [PATCH v2 0/5] arm: dts: complete dm816x device tree
Message-ID: <56449D1D.4030803@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to fix support for the dm816x platform, add missing bits in
the dm816x dtsi and cleanup OCP.

The last patch adds support for the omap4-hwspinlock.

v2: add ocp hwmod cleanup

Neil Armstrong (5):
  arm: dts: add dm816x missing #mbox-cells
  arm: dts: add dm816x missing spi DT dma handles
  arm: dts: add dm816x pwm property to timers
  arm: dts: remove dm816x invalid DT l3_main hwmod
  arm: dts: Add omap4-hwspinlock support in dm816x

 arch/arm/boot/dts/dm816x.dtsi | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
1.9.1
