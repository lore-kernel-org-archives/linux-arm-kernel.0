From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Dec 2015 14:59:51 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.5 (#3)
Message-ID: <87bn9nsvqg.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for dt for mvebu for v4.5. I thinks this
should be the last PR for 4.5. However, Linus said that he planned to
open the merge windows for 4.5 around Jan 10th. So if new patches are
coming during the week-end I don't exclude releasing a new PR next week
unless you already know that you won't take any new PR.

Gregory

The following changes since commit 4c945e8556ec7ea5b19d4f8721b212f468656e0d:

  ARM: dts: Add SolidRun Armada 388 Clearfog A1 DT file (2015-12-08 17:58:01 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.5-3

for you to fetch changes up to 8b44f5be20fd531054e546b662f46e619bff2e72:

  ARM: dts: armada: replace isil, irq2-can-wakeup-machine with wakeup-source property (2015-12-15 17:55:35 +0100)

----------------------------------------------------------------
mvebu dt for 4.5 (part 3)

Add dts for the following boards:
- Zyxel NSA325
- PogoPlug series 4
Add GPU support for Dove
Update boolean property to wakeup source for isil

----------------------------------------------------------------
Hans Ulli Kroll (1):
      ARM: dts: kirkwood: Add DTS for Zyxel NSA325

Linus Walleij (2):
      ARM: mvebu: add kirkwood compatibles for cloudengine boards
      ARM: mvebu: kirkwood: add PogoPlug series 4 device tree

Russell King (2):
      ARM: dts: dove: add DT GPU support
      ARM: dts: enable GPU for SolidRun's Cubox

Sudeep Holla (1):
      ARM: dts: armada: replace isil, irq2-can-wakeup-machine with wakeup-source property

 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   2 +-
 arch/arm/boot/dts/dove-cubox.dts                   |   8 +
 arch/arm/boot/dts/dove.dtsi                        |  16 ++
 arch/arm/boot/dts/kirkwood-nsa325.dts              | 238 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts   | 178 +++++++++++++++
 9 files changed, 447 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa325.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
