From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Sat, 20 Oct 2018 14:06:00 +0530
Subject: [PATCH 0/3] Add nvmem driver support for ZynqMP
Message-ID: <20181020083603.27602-1-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches are created On top of the
below repo 
//git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
BRANCH: next/drivers

Nava kishore Manne (3):
  firmware: xilinx: Add zynqmp_pm_get_chipid() API
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
  nvmem: zynqmp: Added zynqmp nvmem firmware driver

 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           | 37 ++++++++++
 drivers/firmware/xilinx/zynqmp.c                   | 24 ++++++
 drivers/nvmem/Kconfig                              | 15 ++--
 drivers/nvmem/Makefile                             |  5 +-
 drivers/nvmem/zynqmp_nvmem.c                       | 86 ++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  2 +
 6 files changed, 159 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

-- 
2.7.4
