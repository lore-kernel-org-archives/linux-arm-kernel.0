From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 13 Jun 2018 16:13:12 +0000
Subject: [PATCH 0/2] mtd: rawnand: meson: add Amlogic NAND driver support
Message-ID: <20180613161314.14894-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  These two patches try to add initial NAND driver support for Amlogic Meson
SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.

Liang Yang (2):
  dt-bindings: nand: meson: add Amlogic NAND controller driver
  mtd: rawnand: meson: add support for Amlogic NAND flash controller

 .../bindings/mtd/amlogic,meson-nand.txt       |  118 ++
 drivers/mtd/nand/raw/Kconfig                  |    8 +
 drivers/mtd/nand/raw/Makefile                 |    3 +
 drivers/mtd/nand/raw/meson_nand.c             | 1422 +++++++++++++++++
 4 files changed, 1551 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 drivers/mtd/nand/raw/meson_nand.c

-- 
2.17.1
