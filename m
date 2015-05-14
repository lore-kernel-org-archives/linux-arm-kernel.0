From: lee@kernel.org (Lee Jones)
Date: Thu, 14 May 2015 10:23:30 +0100
Subject: [GIT PULL] RaspberryPi Device Tree changes due for v4.2
Message-ID: <20150514092330.GE22418@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM-SoC chaps,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git tags/rpi-dt-for-armsoc-v4.2

for you to fetch changes up to 1215baa7a391713dd1d015c209bd87c0a5d89db6:

  ARM: bcm2835: dt: Use 0x4 prefix for DMA bus addresses to SDRAM. (2015-05-14 10:02:34 +0100)

----------------------------------------------------------------
RaspberryPi Device Tree changes due for v4.2

----------------------------------------------------------------
Baruch Siach (1):
      ARM: bcm2835: dt: Fix i2c0 node name

Eric Anholt (2):
      ARM: bcm2835: dt: Add the mailbox to the device tree
      ARM: bcm2835: dt: Use 0x4 prefix for DMA bus addresses to SDRAM.

Stefan Wahren (4):
      ARM: bcm2835: dt: Add vendor prefix for Raspberry Pi
      ARM: bcm2835: dt: Add root properties for Raspberry Pi
      ARM: bcm2835: dt: Add header file for pinctrl constants
      ARM: bcm2835: dt: Use pinctrl header

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   | 31 ++++++++++++++++++++--
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  4 +--
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  4 +--
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  8 +++---
 arch/arm/boot/dts/bcm2835.dtsi                     | 13 +++++++--
 include/dt-bindings/pinctrl/bcm2835.h              | 27 +++++++++++++++++++
 7 files changed, 76 insertions(+), 12 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/bcm2835.h
