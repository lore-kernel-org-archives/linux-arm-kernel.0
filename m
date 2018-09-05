From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Wed, 5 Sep 2018 12:38:59 +0530
Subject: [RFC PATCH v3 0/3] Add reset driver support for ZynqMP
Message-ID: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Nava kishore Manne (3):
  firmware: xilinx: Add reset API's
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
    controller.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 142 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  40 ++++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-zynqmp.c                       | 115 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 136 ++++++++++++++++++++
 5 files changed, 434 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

-- 
2.7.4
