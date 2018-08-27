From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 27 Aug 2018 20:05:45 +0200
Subject: [PATCH V2 0/3] ARM: dts: add Raspberry Pi Compute Module 3 and IO
 board
Message-ID: <1535393148-24163-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for Rasberry Pi Compute Module 3 and
Compute Module 3 Lite.

Changes in V2:
- add Reviewed-by tag from Rob
- split arm and arm64 into separate patches

Stefan Wahren (3):
  dt-bindings: bcm: Add Raspberry Pi CM3 and CM3L
  ARM: dts: add Raspberry Pi Compute Module 3 and IO board
  arm64: dts: broadcom: Add reference to Compute Module IO Board V3

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
