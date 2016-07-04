From: eric@anholt.net (Eric Anholt)
Date: Sun,  3 Jul 2016 17:45:34 -0700
Subject: [GIT PULL 1/3] bcm2835-dt-next-2016-07-03
In-Reply-To: <1467593136-29524-1-git-send-email-eric@anholt.net>
References: <1467593136-29524-1-git-send-email-eric@anholt.net>
Message-ID: <1467593136-29524-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-dt-next-2016-07-03

for you to fetch changes up to 6a93792774fc72861b7e8efaa3545a88272b4413:

  ARM: bcm2835: dt: Add the ethernet to the device trees (2016-05-31 10:32:34 -0700)

----------------------------------------------------------------
This pull request brings in the change to describe the ethernet in the
DT so that the firmware can tell us its MAC address.

----------------------------------------------------------------
Lubomir Rintel (1):
      ARM: bcm2835: dt: Add the ethernet to the device trees

 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts    |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts    |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts         |  1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts       |  1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm283x.dtsi              |  2 ++
 7 files changed, 44 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
