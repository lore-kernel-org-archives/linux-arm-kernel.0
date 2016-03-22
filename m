From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 22 Mar 2016 12:07:35 +0530
Subject: [PATCH 0/2] ARM: am335x: Add support for ICEv2 board
Message-ID: <1458628657-30468-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for AM3359 ICEv2 board.

Boot log: http://pastebin.ubuntu.com/15470564/ 

Lokesh Vutla (2):
  ARM: dts: am335x: Add initial support for ICEv2 board
  ARM: omap2plus_defconfig: Enable GPIO_TPIC2810

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-icev2.dts                 | 303 +++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig               |   1 +
 4 files changed, 308 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-icev2.dts

-- 
2.1.4
