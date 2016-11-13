From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 13 Nov 2016 18:12:07 +0000
Subject: [PATCH 0/2] ARM: bcm2835: Fix names for the Raspberry Pi GPIO lines
Message-ID: <1479060729-25769-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series should fix and extend the patch V4 "ARM: bcm2835: Add names
for the Raspberry Pi GPIO lines" from Linus Walleij and Eric Anholt.

Stefan Wahren (2):
  ARM: bcm2835: Fix names for the Raspberry Pi GPIO lines
  ARM: bcm2835: Add names for the Raspberry Pi Zero GPIO lines

 arch/arm/boot/dts/bcm2835-rpi-a-plus-gpio.dtsi |   75 +++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts       |   76 +-----------------------
 arch/arm/boot/dts/bcm2835-rpi-a.dts            |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts       |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts            |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts         |   11 +---
 6 files changed, 82 insertions(+), 90 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-a-plus-gpio.dtsi

-- 
1.7.9.5
