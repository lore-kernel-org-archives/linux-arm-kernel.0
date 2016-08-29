From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Aug 2016 12:38:57 -0700
Subject: [GIT PULL] bcm2835-dt-next-2016-08-29
Message-ID: <20160829193857.29994-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/anholt/linux bcm2835-dt-next-2016-08-29

for you to fetch changes up to c8336249c1eeca288919e3286f7dd03ae1d8ceae:

  ARM: dts: bcm2835: Add Raspberry Pi Zero (2016-08-24 13:33:19 -0700)

----------------------------------------------------------------
This pull request brings in support for Raspberry Pi Zero.

----------------------------------------------------------------
Stefan Wahren (4):
      ARM: dts: bcm283x: Add missing USB clock
      ARM: dts: bcm283x: Add dtsi for USB host mode
      DT: bindings: bcm: Add Raspberry Pi Zero
      ARM: dts: bcm2835: Add Raspberry Pi Zero

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  4 +++
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  1 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             | 40 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  1 +
 arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi        |  3 ++
 arch/arm/boot/dts/bcm283x.dtsi                     |  9 +++++
 11 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi
