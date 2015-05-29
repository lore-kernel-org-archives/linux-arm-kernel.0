From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 May 2015 19:47:13 +0200
Subject: [PATCH 00/16] AT91 DT for 4.2
Message-ID: <1432921649-21943-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A dt series for 4.2:
 - Fix at91sam9rl RTC node and use it on at91sam9rlek
 - correct stdout-path for the various kizboxes
 - add stdout-path to the atme evaluation boards
 - add  Acme arietta g25 device tree

Alexandre Belloni (16):
  ARM: at91/dt: at91sam9rl: fix rtc node
  ARM: at91/dt: at91sam9rlek: add RTC
  ARM: at91/dt: kizbox: use stdout-path
  ARM: at91/dt: at91rm9200ek: use stdout-path
  ARM: at91/dt: at91sam9261ek: use stdout-path
  ARM: at91/dt: at91sam9263ek: use stdout-path
  ARM: at91/dt: at91sam9g20ek: use stdout-path
  ARM: at91/dt: at91sam9m10g45ek use stdout-path
  ARM: at91/dt: at91sam9n12ek: use stdout-path
  ARM: at91/dt: at91sam9rlek: use stdout-path
  ARM: at91/dt: at91sam9x5ek: use stdout-path
  ARM: at91/dt: sama5d3xek: use stdout-path
  ARM: at91/dt: sama5d3 xplained: use stdout-path
  ARM: at91/dt: sama5d4ek: use stdout-path
  ARM: at91/dt: sama5d4 xplained: use stdout-path
  ARM: at91/dt: Add Acme Arietta G25

 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/at91-acme-arietta.dts     | 75 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91-kizbox.dts           |  2 +-
 arch/arm/boot/dts/at91-kizbox2.dts          |  2 +-
 arch/arm/boot/dts/at91-kizboxmini.dts       |  2 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts |  2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts |  3 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        |  3 +-
 arch/arm/boot/dts/at91rm9200ek.dts          |  4 ++
 arch/arm/boot/dts/at91sam9261ek.dts         |  3 +-
 arch/arm/boot/dts/at91sam9263ek.dts         |  3 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  3 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  3 +-
 arch/arm/boot/dts/at91sam9n12ek.dts         |  3 +-
 arch/arm/boot/dts/at91sam9rl.dtsi           | 15 +++---
 arch/arm/boot/dts/at91sam9rlek.dts          |  7 ++-
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |  3 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi           |  3 +-
 18 files changed, 116 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-acme-arietta.dts

-- 
2.1.4
