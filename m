From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 29 Jun 2017 14:44:29 +0300
Subject: [PATCH 0/5] Add SoM1 support
Message-ID: <1498736674-9233-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series adds support for sama5d2 SoM1 devices.

The at91-sama5d27_som1.dtsi add specific bindings for SoM1 board.
The at91-sama5d27_som1_ek.dts add specific bindings for SoM1 EK board.

The sama5d27_som1_ek uses a EEPROM binding, "start-offset", which is
introduced in patch series: "[RFC PATCH 0/3] Add at24 functionality to
read form different EEPROM offsets".

Thank you,
Claudiu

Claudiu Beznea (2):
  ARM: dts: at91: at91-sama5d27_som1: add sama5d27 SoM1 support
  ARM: dts: sama5d27_som1_ek: Add sama5d27 SoM1 EK support

Cristian Birsan (1):
  drivers: soc: atmel: Add basic support for new sama5d2 SiPs

Cyrille Pitchen (1):
  ARM: dts: at91: sama5d2: add QSPI nodes

Songjun Wu (1):
  ARM: dts: at91: sama5d2: add isc node

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 178 +++++++++
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 551 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              |  38 ++
 drivers/soc/atmel/soc.c                     |   8 +
 drivers/soc/atmel/soc.h                     |   4 +
 6 files changed, 780 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts

-- 
2.7.4
