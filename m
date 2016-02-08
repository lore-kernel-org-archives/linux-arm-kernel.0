From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 8 Feb 2016 11:59:05 -0600
Subject: [PATCH V2 00/12] dtb: amd: Miscelleneous Updates for AMD Seattle DTS
Message-ID: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This patch series contains several updates for the AMD Seattle SOC DTS files.
It also adds new board files for newer Overdrive and Linaro 96boards (Husky)
platforms.

Thanks,
Suravee

Changes from V1 (https://lkml.org/lkml/2016/1/27/1251):
  * Fix duplication in MAINTAINERS file (per Martin review comment)
  * Remove the PCIe SMMU device tree node for now to rework
    (based on the discussion in the thread).

Brijesh Singh (2):
  dtb: amd: Fix GICv2 hypervisor and virtual interface sizes
  dtb: amd: Add KCS device tree node

Suravee Suthikulpanit (9):
  MAINTAINERS: Adding Maintainers for AMD Seattle Device Tree
  dtb: amd: Fix DMA ranges in device tree
  dtb: amd: Fix typo in SPI device nodes
  dtb: amd: Misc changes for I2C device nodes
  dtb: amd: Misc changes for SATA device tree nodes
  dtb: amd: Misc changes for GPIO devices
  dtb: amd: Add PERF CCN-504 device tree node
  dtb: amd: Add support for new AMD Overdrive boards
  dtb: amd: Add support for AMD/Linaro 96Boards Enterprise Edition
    Server board

Tom Lendacky (1):
  dtb: amd: Add AMD XGBE device tree file

 MAINTAINERS                                      |   8 ++
 arch/arm64/boot/dts/amd/Makefile                 |   4 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts |  87 +++++++++++++++++
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts |  91 ++++++++++++++++++
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi     | 105 +++++++++++++++++---
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi  | 117 +++++++++++++++++++++++
 arch/arm64/boot/dts/amd/husky.dts                |  83 ++++++++++++++++
 7 files changed, 481 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
 create mode 100644 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
 create mode 100644 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/husky.dts

-- 
2.5.0
