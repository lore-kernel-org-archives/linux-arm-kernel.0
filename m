From: eric@anholt.net (Eric Anholt)
Date: Thu, 30 Mar 2017 12:13:43 -0700
Subject: [GIT PULL] bcm2835-dt-next-2017-03-30
Message-ID: <20170330191343.31647-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Here's the pull request for those changes I'd misplaced from 4.11.
This may be my last PR of the cycle.  The only change I have left on
my radar for 4.12 is
http://lists.infradead.org/pipermail/linux-rpi-kernel/2017-March/006097.html

The following changes since commit 7f31a955a0c34de0463f7ff50b2bd62a5cce4204:

  ARM: dts: bcm2835: add sdhost controller to devicetree (2017-03-17 17:35:50 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2017-03-30

for you to fetch changes up to 10b6c0c2e2bb8cd1be682f8d36ef597e3419cb88:

  ARM: dts: bcm2835: add index to the ethernet alias (2017-03-27 10:10:39 -0700)

----------------------------------------------------------------
This pull request brings back bcm2835 DT fixups from Baruch Siach that
got misplaced after a PR for 4.11 got rejected.

----------------------------------------------------------------
Baruch Siach (4):
      ARM: dts: bcm2835: fix uart0 pinctrl node names
      ARM: dts: bcm2835: fix i2c0 pins
      ARM: dts: bcm2835: fix uart0/uart1 pins
      ARM: dts: bcm2835: add index to the ethernet alias

 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi |  2 +-
 arch/arm/boot/dts/bcm283x.dtsi              | 22 +++++++++++++---------
 3 files changed, 15 insertions(+), 11 deletions(-)
