From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Mon, 9 Oct 2017 19:09:22 +0300
Subject: [PATCH 00/14] at91 fixes and enhancements
Message-ID: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series contains fixes and enhancements for Atmel/Microchip boards,
mainly for SoM1-EK board, SAMA5D2 Xplained board and SAM9x5 boards.
Please accept them for 4.15.

Thank you,
Claudiu Beznea

Claudiu Beznea (14):
  ARM: dts: at91: sama5d27_som1_ek: add disabled/okay status
  ARM: dts: at91: sama5d27_som1_ek: update serial aliases
  ARM: dts: at91: sama5d27_som1_ek: set USER button as a wakeup source
  ARM: dts: at91: sama5d27_som1_ek: add aliases for i2c
  ARM: dts: at91: sama5d27_som1_ek: add pinmuxing for pwm0
  ARM: dts: at91: sama5d27_som1_ek: remove not connected CAN0
  ARM: dts: at91: sama5d27_som1_ek: remove pull-up on SD/MMC lines
  ARM: dts: at91: sama5d2_xplained: Add charger node of pmic.
  ARM: dts: at91: sama5d2_xplained: set PB_USER as wakeup source
  ARM: dts: at91: sama5d2_xplained: add pinmuxing for pwm0
  ARM: dts: at91: sama5d2_xplained: remove pull-up on SD/MMC lines
  ARM: dts: at91: at91sam9x25ek: add CAN1 interface
  ARM: dts: at91: at91sam9x25ek: add pwm0
  ARM: dts: at91: at91sam9x5ek: use DMA for USART0

 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 46 ++++++++++++++---------------
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 39 ++++++++++++++++--------
 arch/arm/boot/dts/at91sam9x25ek.dts         | 10 +++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |  2 ++
 4 files changed, 62 insertions(+), 35 deletions(-)

-- 
2.7.4
