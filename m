From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 12 Nov 2018 14:31:01 +0100
Subject: [PATCH v3 0/7] clk: at91: Rework DT bindings
Message-ID: <20181112133108.31021-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the remaining part of the clock rework series.

I'll convert the remaining SoCs later this cycle.

Changes in v3:
 - Dropped clk patches that have been applied
 - Rebased on top of v4.20-rc1

Alexandre Belloni (7):
  ARM: dts: at91: sama5d4: switch to new clock bindings
  ARM: dts: at91: sama5d2: switch to new binding
  ARM: dts: at91: at91sam9260: switch to new clock bindings
  ARM: dts: at91: at91sam9261: switch to new clock bindings
  ARM: dts: at91: at91sam9263: switch to new clock bindings
  ARM: dts: at91: at91sam9x5: switch to new clock bindings
  ARM: dts: at91: at91sam9rl: switch to new clock bindings

 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi          | 308 +--------
 arch/arm/boot/dts/at91sam9261.dtsi          | 287 +--------
 arch/arm/boot/dts/at91sam9263.dtsi          | 315 +--------
 arch/arm/boot/dts/at91sam9g15.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9g20.dtsi          |  23 +-
 arch/arm/boot/dts/at91sam9g25.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9g25ek.dts         |   4 +-
 arch/arm/boot/dts/at91sam9g35.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9rl.dtsi           | 239 +------
 arch/arm/boot/dts/at91sam9x25.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9x35.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9x5.dtsi           | 326 +---------
 arch/arm/boot/dts/at91sam9x5_can.dtsi       |  18 +-
 arch/arm/boot/dts/at91sam9x5_isi.dtsi       |  11 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi       |  19 +-
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi     |  11 +-
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi     |  11 +-
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi    |  11 +-
 arch/arm/boot/dts/sama5d2.dtsi              | 670 ++------------------
 arch/arm/boot/dts/sama5d4.dtsi              | 535 ++--------------
 24 files changed, 287 insertions(+), 2541 deletions(-)

-- 
2.19.1
