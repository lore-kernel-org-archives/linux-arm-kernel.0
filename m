From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Mar 2015 10:49:02 +0100
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.1 (round 2)
Message-ID: <550BED0E.8090308@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.1.

Actually there are two more commits in the dt branch but they
didn't have been merged yet in linux-next. I prefer be safe
and wait for they spend a few days in linux-next.

Gregory

The following changes since commit 538da83ddbeaa422a48e9bd0a12a0bc246c567f4:

  ARM: mvebu: add Device Tree files for Armada 39x SoC and board (2015-03-04 15:42:34 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.1-2

for you to fetch changes up to 7776ab70d75ff9857343e44e428744d81c30ce1b:

  ARM: mvebu: armada-385-ap: Enable USB3 port (2015-03-18 11:55:49 +0100)

----------------------------------------------------------------
mvebu dt changes for v4.1 (part #2)

- add support for Performance Monitor Unit on most of mvebu SoCs
- add nas2big support
- add support for USB3 port On Armada 385 AP

----------------------------------------------------------------
Ezequiel Garcia (2):
      ARM: mvebu: Enable Performance Monitor Unit on Armada 375 SoC
      ARM: mvebu: Enable Performance Monitor Unit on Armada 380/385 SoC

Maxime Ripard (2):
      ARM: mvebu: Enable Performance Monitor Unit on Armada XP/370 SoCs
      ARM: mvebu: armada-385-ap: Enable USB3 port

Simon Guinot (1):
      ARM: Kirkwood: add DT description for nas2big

 Documentation/devicetree/bindings/arm/marvell,kirkwood.txt |   1 +
 arch/arm/boot/dts/Makefile                                 |   1 +
 arch/arm/boot/dts/armada-370-xp.dtsi                       |   5 +++++
 arch/arm/boot/dts/armada-375.dtsi                          |   5 +++++
 arch/arm/boot/dts/armada-385-db-ap.dts                     |  28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-38x.dtsi                          |   5 +++++
 arch/arm/boot/dts/kirkwood-nas2big.dts                     | 143
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 188 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-nas2big.dts

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
