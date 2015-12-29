From: eric@anholt.net (Eric Anholt)
Date: Mon, 28 Dec 2015 21:01:21 -0800
Subject: [GIT PULL 3/4] BCM2835 DT changes for 4.5
In-Reply-To: <1451365282-10505-1-git-send-email-eric@anholt.net>
References: <1451365282-10505-1-git-send-email-eric@anholt.net>
Message-ID: <1451365282-10505-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f74875dc36135ebae82a8e005f4b7f52289d2c40:

  usb: dwc2: fix kernel oops during driver probe (2015-11-20 09:29:47 -0600)

are available in the git repository at:

  http://github.com/anholt/linux tags/bcm2835-dt-next-2015-12-28

for you to fetch changes up to 53b6084357a44d7c34044504e1bf149d9156934f:

  ARM: bcm2835: Add the auxiliary clocks to the device tree. (2015-12-26 14:44:09 -0800)

----------------------------------------------------------------
This pull request includes the bcm2835 changes for 4.5 targeting the
arm-soc next/dt branch.

----------------------------------------------------------------
Eric Anholt (4):
      ARM: bcm2835: Split the DT for peripherals from the DT for the CPU
      ARM: bcm2835: Move the CPU/peripheral include out of common RPi DT.
      ARM: bcm2835: Add devicetree for bcm2836 and Raspberry Pi 2 B
      ARM: bcm2835: Add the auxiliary clocks to the device tree.

 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts      |   1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi       |   2 -
 arch/arm/boot/dts/bcm2835.dtsi           | 194 +---------------------------
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    |  35 +++++
 arch/arm/boot/dts/bcm2836.dtsi           |  78 ++++++++++++
 arch/arm/boot/dts/bcm283x.dtsi           | 212 +++++++++++++++++++++++++++++++
 10 files changed, 332 insertions(+), 196 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2836-rpi-2-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2836.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x.dtsi
