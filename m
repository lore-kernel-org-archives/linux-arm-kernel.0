From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Mon, 30 Jul 2018 14:40:05 +0300
Subject: [PATCH v6 0/3] ARM: dts: at91: sama5d2: Add nodes for I2S
Message-ID: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are the remaining dts patches from the series:
[PATCH v5 0/5] ASoC: add driver for Atmel I2S controller

v5 -> v6
 - removed unnecessary phandles to audio PLL clock from the I2S nodes;
 - using assigned clocks to set gclk as parent of i2smuxclk;

Codrin Ciubotariu (1):
  ARM: dts: at91: sama5d2: add I2S clock muxing nodes

Cyrille Pitchen (2):
  ARM: dts: at91: sama5d2: add nodes for I2S controllers
  ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 28 +++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 56 +++++++++++++++++++++
 2 files changed, 84 insertions(+)

-- 
2.17.1
