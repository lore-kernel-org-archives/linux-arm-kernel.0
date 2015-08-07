From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 07 Aug 2015 18:01:39 +0200
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.3 #3
Message-ID: <55C4D663.4050508@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third  pull request for dt for mvebu for v4.3

Gregory

he following changes since commit dc57844a736f10bf3799d63d7c0d0efc29b1ad7d:

  ARM: dts: orion5x: add buffalo linkstation ls-wtgl (2015-07-25 16:19:20 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.3-3

for you to fetch changes up to 15979aeeb548e020b6107214f0405be894891a57:

  ARM: dts: Convert Linkstation Mini to Device Tree (2015-08-06 18:51:29 +0200)

----------------------------------------------------------------
mvebu dt changes for v4.3 (part #3)

- device tree part of the Dove PMU series
- converting a new orion5x based platform to dt: Linkstation Mini

----------------------------------------------------------------
Benjamin Cama (1):
      ARM: dts: Convert Linkstation Mini to Device Tree

Russell King (4):
      ARM: dt: Add PMU node, making PMU child devices childs of this node
      ARM: dt: dove: wire up RTC interrupt
      ARM: dt: dove: add video decoder power domain description
      ARM: dt: dove: add GPU power domain description

 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/dove.dtsi          | 604 ++++++++++++++++++-----------------
 arch/arm/boot/dts/orion5x-lswsgl.dts | 276 ++++++++++++++++
 arch/arm/mach-orion5x/Kconfig        |   6 +-
 arch/arm/mach-orion5x/Makefile       |   1 -
 arch/arm/mach-orion5x/lsmini-setup.c | 280 ----------------
 6 files changed, 598 insertions(+), 570 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-lswsgl.dts
 delete mode 100644 arch/arm/mach-orion5x/lsmini-setup.c
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
