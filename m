From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Fri, 26 Oct 2018 17:54:21 +0530
Subject: [PATCH v2 0/3] Add reset driver support for ZynqMP
Message-ID: <20181026122424.30831-1-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches are created On top of the
below repo.
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git (fetch)
BRANCH: next/drivers 

Nava kishore Manne (3):
  firmware: xilinx: Add reset API's
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
    controller.

 .../bindings/reset/xlnx,zynqmp-reset.txt           | 146 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  40 ++++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-zynqmp.c                       | 114 ++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 136 +++++++++++++++++++
 5 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 drivers/reset/reset-zynqmp.c

-- 
2.7.4
