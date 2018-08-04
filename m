From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  4 Aug 2018 13:10:01 +0200
Subject: [PATCH 0/2] ARM: dts: add Raspberry Pi Compute Module 3 and IO board
Message-ID: <1533381003-13367-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for Rasberry Pi Compute Module 3 and
Compute Module 3 Lite.

Stefan Wahren (2):
  dt-bindings: bcm: Add Raspberry Pi CM3 and CM3L
  ARM: dts: add Raspberry Pi Compute Module 3 and IO board

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  8 ++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          | 87 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             | 52 +++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile              |  3 +-
 .../boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts      |  2 +
 6 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts

-- 
2.7.4
