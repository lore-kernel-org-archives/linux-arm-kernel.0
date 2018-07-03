From: eric@anholt.net (Eric Anholt)
Date: Tue,  3 Jul 2018 13:05:08 -0700
Subject: [GIT PULL 1/4] bcm2835-dt-next-2018-07-03
Message-ID: <20180703200511.2725-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-07-03

for you to fetch changes up to 7503668f7287a359f234cd000f4ca8572e40677b:

  ARM: dts: bcm283x: Add Transposer block (2018-07-02 12:46:20 -0700)

----------------------------------------------------------------
This pull request brings in a board DT for the Raspberry Pi Compute
Module and its I/O board, the Pi3's PMU node, and the display's
transposer block.

----------------------------------------------------------------
Boris Brezillon (1):
      ARM: dts: bcm283x: Add Transposer block

Eric Anholt (1):
      arm: bcm2835: Add the PMU to the devicetree.

Stefan Wahren (1):
      ARM: dts: add Raspberry Pi Compute Module and IO board

 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts | 88 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi    | 34 ++++++++++++
 arch/arm/boot/dts/bcm2837.dtsi            |  6 +++
 arch/arm/boot/dts/bcm283x.dtsi            |  6 +++
 5 files changed, 135 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
