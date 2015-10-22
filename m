From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 22 Oct 2015 11:19:05 +0200
Subject: [PATCH 0/4] arm: dts: complete dm816x device tree
Message-ID: <5628AA09.506@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to fix support for the dm816x platform, add missing bits in
the dm816x dtsi.

The last patch adds support for the omap4-hwspinlock.

Neil Armstrong (4):
  arm: dts: add dm816x missing #mbox-cells
  arm: dts: add dm816x missing spi DT dma handles
  arm: dts: add dm816x pwm property to timers
  arm: dts: Add omap4-hwspinlock support in dm816x

 arch/arm/boot/dts/dm816x.dtsi | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
1.9.1
