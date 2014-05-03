From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:35:09 +0200
Subject: [PATCH v2 0/5] DT support for LaCie 2Big and 5Big Network v2
Message-ID: <1399142114-24257-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Fix Memory size
Make Ethernet nodes simpler.

Andrew Lunn (5):
  ARM: Kirkwood: Add board file for netxbig LEDs
  ARM: Kirkwood: Add DT descriptions for net2big and net5big.
  ARM: Kirkwood: Document net[25x]big compatible strings
  ARM: mvebu: Add LaCie 2Big and 5Big Network v2
  ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2

 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   3 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/kirkwood-net2big.dts             |  30 ++++
 arch/arm/boot/dts/kirkwood-net5big.dts             |  83 +++++++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            | 171 ++++++++++++++++++
 arch/arm/configs/multi_v5_defconfig                |   1 +
 arch/arm/configs/mvebu_v5_defconfig                |   1 +
 arch/arm/mach-mvebu/Kconfig                        |   7 +
 arch/arm/mach-mvebu/Makefile                       |   1 +
 arch/arm/mach-mvebu/board-netxbig.c                | 191 +++++++++++++++++++++
 arch/arm/mach-mvebu/board.h                        |   6 +
 arch/arm/mach-mvebu/kirkwood.c                     |   3 +
 12 files changed, 499 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi
 create mode 100644 arch/arm/mach-mvebu/board-netxbig.c

-- 
2.0.0.rc0
