From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 30 Dec 2015 15:38:59 +0200
Subject: [PATCH 0/6] ARM: dts: am57xx: cl-som-am57x: set of non critical DT
 fixes
Message-ID: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pacth set apply a set of non critical DT fixes for CompuLab CL-SOM-AM57x SoM

* Improve Eth functionality
* Pinmux fix for several devices
* Improve SPI flash access
* Set USB2 in HOST mode to enable connection of keyboard/mouse on eval board

Dmitry Lifshitz (6):
  ARM: dts: am57xx: sbc-am57x: fix SB-SOM EEPROM I2C address
  ARM: dts: am57xx: cl-som-am57x: set HOST mode for USB2
  ARM: dts: am57xx: cl-som-am57x: update SPI Flash frequency
  ARM: dts: am57xx: sbc-am57x: fix UART3 pinmux
  ARM: dts: am57xx: cl-som-am57x: fix CPSW EMAC pinmux
  ARM: dts: am57xx: sbc-am57x: correct Eth PHY settings

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 12 ++++++------
 arch/arm/boot/dts/am57xx-sbc-am57x.dts    |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1
