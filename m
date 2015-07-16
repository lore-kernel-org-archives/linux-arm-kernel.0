From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 17 Jul 2015 00:09:39 +0200
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.3
Message-ID: <55A82BA3.1090001@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.3

Gregory

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.3-1

for you to fetch changes up to 7e5308be4c0747e328d03f3daa46aaa5eaf7714f:

  ARM: mvebu: update EEPROM description of Armada 388 GP (2015-07-09 15:28:08 +0200)

----------------------------------------------------------------
mvebu dt changes for v4.3 (part #1)

- Update Armada 388 GP description
- Add Buffalo Linkstation  LS-WXL and LS-WSXL
- Fine-tune the L2 configuration for cortex A9 based SoC
- Update XOR definition for Armada 38x and 39x SoC

----------------------------------------------------------------
Roger Shimizu (2):
      ARM: dts: add buffalo linkstation ls-wxl/wsxl
      ARM: dts: add buffalo linkstation ls-wvl/vl

Thomas Petazzoni (4):
      ARM: mvebu: use armada-380-xor on Armada 38x and 39x
      ARM: mvebu: use DT properties to fine-tune the L2 configuration
      ARM: mvebu: fix description of pwr-sata0 regulator on Armada 388 GP
      ARM: mvebu: update EEPROM description of Armada 388 GP

 Documentation/devicetree/bindings/arm/marvell,kirkwood.txt |   2 +
 arch/arm/boot/dts/Makefile                                 |   2 +
 arch/arm/boot/dts/armada-375.dtsi                          |   4 ++
 arch/arm/boot/dts/armada-388-gp.dts                        |  12 +++--
 arch/arm/boot/dts/armada-38x.dtsi                          |   8 +++-
 arch/arm/boot/dts/armada-39x.dtsi                          |   8 +++-
 arch/arm/boot/dts/kirkwood-lswvl.dts                       | 301 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-lswxl.dts                       | 301 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 629 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-lswvl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-lswxl.dts

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
