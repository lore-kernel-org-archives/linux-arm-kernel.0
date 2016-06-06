From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Mon,  6 Jun 2016 13:24:17 +0300
Subject: [PATCH 0/7] dts: sunxi: Add sunxi NAND Flash Controller support
Message-ID: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds the sunxi NAND Flash Controller nodes to dts.

The first 4 patches is Boris Brezillon's patches with dtsi changes.
The second 1 patch adds Hynix H27UBG8T2BTR-BC NAND chip definition.
The last 2 patches enables NAND on Marsboard A10 board and Wexler TAB7200
tablet.

Aleksei Mamlin (3):
  mtd: nand: Add Hynix H27UBG8T2BTR-BC to nand_ids table
  ARM: dts: sun4i: Enable NAND on Marsboard A10
  ARM: dts: sun7i: Enable NAND on Wexler TAB7200

Boris Brezillon (4):
  ARM: dts: sun4i: Add A10 NAND controller pin definitions
  ARM: dts: sun4i: Add NFC node to Allwinner A10 SoC
  ARM: dts: sun7i: Add A20 NAND controller pin definitions
  ARM: dts: sun7i: Add NFC node to Allwinner A20 SoC

 arch/arm/boot/dts/sun4i-a10-marsboard.dts      | 41 ++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi               | 91 ++++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 41 ++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi               | 91 ++++++++++++++++++++++++++
 drivers/mtd/nand/nand_ids.c                    |  4 ++
 5 files changed, 268 insertions(+)

-- 
2.7.3
