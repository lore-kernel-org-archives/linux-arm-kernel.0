From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:11:48 -0600
Subject: [PATCH 00/13] dtb: amd: Miscelleneous Updates for AMD Seattle DTS
Message-ID: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This patch series contains several updates for the AMD Seattle SOC DTS files.
It also adds new board files for newer Overdrive and Linaro 96boards (Husky)
platforms.

Thanks,
Suravee

Brijesh Singh (2):
  dtb: amd: Fix GICv2 hypervisor and virtual interface sizes
  dtb: amd: Add KCS device tree node

Suravee Suthikulpanit (10):
  MAINTAINERS: Adding Maintainers for AMD Seattle Device Tree
  dtb: amd: Fix DMA ranges in device tree
  dtb: amd: Fix typo in SPI device nodes
  dtb: amd: Misc changes for I2C device nodes
  dtb: amd: Misc changes for SATA device tree nodes
  dtb: amd: Misc changes for GPIO devices
  dtb: amd: Add PERF CCN-504 device tree node
  dtb: amd: Add PCIe SMMU device tree node
  dtb: amd: Add support for new AMD Overdrive boards
  dtb: amd: Add support for AMD/Linaro 96Boards Enterprise Edition
    Server board

Tom Lendacky (1):
  dtb: amd: Add AMD XGBE device tree file

 MAINTAINERS                                      |   9 ++
 arch/arm64/boot/dts/amd/Makefile                 |   4 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts |  87 +++++++++++++++
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts |  91 ++++++++++++++++
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi     | 128 ++++++++++++++++++++---
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi  | 117 +++++++++++++++++++++
 arch/arm64/boot/dts/amd/husky.dts                |  83 +++++++++++++++
 7 files changed, 505 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
 create mode 100644 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
 create mode 100644 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
 create mode 100644 arch/arm64/boot/dts/amd/husky.dts

-- 
2.5.0
