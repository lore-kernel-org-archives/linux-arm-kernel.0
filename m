From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Wed, 5 Sep 2018 12:54:45 +0530
Subject: [RFC PATCH v2 0/3] Add Bitstream configuration support for ZynqMP
Message-ID: <20180905072448.12488-1-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt  |  13 ++
 drivers/firmware/xilinx/zynqmp.c              |  46 +++++
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   4 +
 6 files changed, 232 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.18.0
