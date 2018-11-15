From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 16 Nov 2018 00:00:05 +0100
Subject: [PATCH 0/3] ARM: dts: add Raspberry Pi 3 A+
In-Reply-To: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
References: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1542322805-6211-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the brand new Raspberry Pi 3 A+ .

Stefan Wahren (3):
  dt-bindings: bcm: Add Raspberry Pi 3 A+
  ARM: dts: add Raspberry Pi 3 A+
  arm64: dts: broadcom: Add reference to RPi 3 A+

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         | 107 +++++++++++++++++++++
 .../boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts     |   2 +
 4 files changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

-- 
2.7.4
