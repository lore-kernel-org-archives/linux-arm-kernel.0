From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 16 Nov 2016 17:52:05 +0000
Subject: [PATCH V2 0/2] ARM: bcm2835: Fix names for the Raspberry Pi GPIO lines
Message-ID: <1479318727-9425-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series should fix and extend the patch V4 "ARM: bcm2835: Add names
for the Raspberry Pi GPIO lines" from Linus Walleij and Eric Anholt.

Changes in V2:
  - fix URL to firmware DT blob
  - drop dtsi file since Model A+ and Zero aren't identical

Stefan Wahren (2):
  ARM: bcm2835: Fix names for the Raspberry Pi GPIO lines
  ARM: bcm2835: Add names for the RPi Zero GPIO lines

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-a.dts      |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts      |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts   |   65 ++++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+), 7 deletions(-)

-- 
1.7.9.5
