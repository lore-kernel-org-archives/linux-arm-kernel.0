From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 15 Jan 2013 06:59:57 -0300
Subject: [PATCH 0/6] arm: mvebu: Add support for USB host controllers in Armada
 370/XP
Message-ID: <50F5289D.80903@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This small patch set enables USB support on Armada 370 and Armada XP platforms.
It's based on Jason Cooper's mvebu/dt branch.

Any comments or feedback are welcome.

Ezequiel Garcia (6):
 arm: mvebu: Add support for USB host controllers in Armada 370/XP
 arm: mvebu: Enable USB controllers on Armada 370 evaluation board
 arm: mvebu: Enable USB controllers on Armada 370 Mirabox board
 arm: mvebu: Enable USB controllers on Armada XP evaluation board
 arm: mvebu: Enable USB controllers on Armada XP OpenBlocks AX3-4 board
 arm: mvebu: Update defconfig to select USB support

 arch/arm/boot/dts/armada-370-db.dts              |    8 ++++++++
 arch/arm/boot/dts/armada-370-mirabox.dts         |    8 ++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi             |   15 +++++++++++++++
 arch/arm/boot/dts/armada-370.dtsi                |    9 +++++++++
 arch/arm/boot/dts/armada-xp-db.dts               |   12 ++++++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    9 +++++++++
 arch/arm/boot/dts/armada-xp.dtsi                 |   17 +++++++++++++++++
 arch/arm/configs/mvebu_defconfig                 |    5 ++++-
 arch/arm/mach-mvebu/Kconfig                      |    1 +
 9 files changed, 83 insertions(+), 1 deletions(-)
 
Thanks!

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
