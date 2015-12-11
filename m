From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 11 Dec 2015 15:20:58 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.5 (#2)
Message-ID: <87mvth6p85.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.5.

Gregory

The following changes since commit 4627629bbb675665e902ad76ab96ac1ee5d17fd8:

  ARM: dt: mvebu: ix4-300d: Cleanup NAND partition ranges (2015-11-30 15:18:31 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.5-2

for you to fetch changes up to 4c945e8556ec7ea5b19d4f8721b212f468656e0d:

  ARM: dts: Add SolidRun Armada 388 Clearfog A1 DT file (2015-12-08 17:58:01 +0100)

----------------------------------------------------------------
mvebu dt for 4.5 (part 2)

- Fix Armada 388 GP dts
- Add clock related to PMU for Dove
- Add SolidRun Armada 388 Clearfog A1 dts

----------------------------------------------------------------
Russell King (4):
      dt-bindings: add Marvell core PLL and clock divider PMU documentation
      ARM: dts: dove: add Dove divider clocks
      dt-bindings: add Marvell PMU documentation
      ARM: dts: Add SolidRun Armada 388 Clearfog A1 DT file

Thomas Petazzoni (1):
      ARM: mvebu: remove duplicated regulator definition in Armada 388 GP

 .../bindings/clock/dove-divider-clock.txt          |  28 ++
 Documentation/devicetree/bindings/soc/dove/pmu.txt |  56 +++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-388-clearfog.dts          | 456 +++++++++++++++++++++
 arch/arm/boot/dts/armada-388-gp.dts                |  10 -
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 115 ++++++
 arch/arm/boot/dts/dove.dtsi                        |   6 +
 7 files changed, 662 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/dove-divider-clock.txt
 create mode 100644 Documentation/devicetree/bindings/soc/dove/pmu.txt
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog.dts
 create mode 100644 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
