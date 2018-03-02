From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  2 Mar 2018 20:21:32 +0100
Subject: [PATCH v3 0/5] arm: zynq: Adding new Xilinx boards
Message-ID: <cover.1520018484.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset is adding 5 new dts files which target cc108 and zc770
boards.
Please let me know if you see any issue with them.

Series depends on this one patch
https://lkml.org/lkml/2018/2/23/412

Thanks,
Michal

Changes in v3:
- Fix partition for flash

Changes in v2:
- Record compatible string to xilinx.txt
- Record compatible string to xilinx.txt
- Record compatible string to xilinx.txt
- Record compatible string to xilinx.txt
- use eeprom as node name instead of at25
- Record compatible string to xilinx.txt

Michal Simek (5):
  arm: zynq: Add Xilinx cc108 board
  arm: zynq: Add support for Xilinx zc770 xm010 dc1 board
  arm: zynq: Add support for Xilinx zc770 xm011 dc2 board
  arm: zynq: Add support for Xilinx zc770 xm012 dc3 board
  arm: zynq: Add support for Xilinx zc770 xm013 dc4 board

 Documentation/devicetree/bindings/arm/xilinx.txt | 11 +++
 arch/arm/boot/dts/Makefile                       |  5 ++
 arch/arm/boot/dts/zynq-cc108.dts                 | 75 +++++++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm010.dts           | 95 ++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm011.dts           | 64 ++++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm012.dts           | 64 ++++++++++++++++
 arch/arm/boot/dts/zynq-zc770-xm013.dts           | 78 +++++++++++++++++++
 7 files changed, 392 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-cc108.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm010.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm011.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm012.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm013.dts

-- 
1.9.1
