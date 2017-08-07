From: eric@anholt.net (Eric Anholt)
Date: Mon,  7 Aug 2017 09:35:30 -0700
Subject: [GIT PULL 1/2] bcm2835-dt-next-2017-08-07
Message-ID: <20170807163531.2940-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3bfe25fa9f8a56c5c877c7fd854d89238787c6d8:

  ARM: dts: bcm283x: Move the BCM2837 DT contents from arm64 to arm. (2017-07-28 16:54:15 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2017-08-07

for you to fetch changes up to 2c7c040c73e9e5686a5b451674b0592551a52345:

  ARM: dts: bcm2835: Add Raspberry Pi Zero W (2017-08-02 15:25:36 -0700)

----------------------------------------------------------------
This pull request brings in a new DT for the Raspberry Pi Zero W.

----------------------------------------------------------------
Stefan Wahren (3):
      ARM: bcm283x: Define UART pinmuxing on board level
      dt-bindings: bcm: Add Raspberry Pi Zero W
      ARM: dts: bcm2835: Add Raspberry Pi Zero W

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   6 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   6 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           | 139 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   6 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   6 +
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  10 ++
 12 files changed, 198 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
