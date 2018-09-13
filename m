From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 13 Sep 2018 07:50:31 +0200
Subject: [GIT PULL 1/3] bcm2835-dt-next-2018-09-09
Message-ID: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-09-09

for you to fetch changes up to 6ef5bd6cfd5da9fe67aea031fd0a66ff77d64ad6:

  ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs (2018-09-05 21:31:25 +0200)

----------------------------------------------------------------
This pull request brings in a board DT for the Raspberry Pi Compute
Module 3, its I/O board and enables the Ethernet LEDs for the RPi 3B+.

----------------------------------------------------------------
Stefan Wahren (3):
      dt-bindings: bcm: Add Raspberry Pi CM3 and CM3L
      ARM: dts: add Raspberry Pi Compute Module 3 and IO board
      ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  8 ++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          | 87 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             | 52 +++++++++++++
 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi         | 14 ++++
 5 files changed, 162 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
