From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 16:29:44 +0100
Subject: [PATCH 0/6] Hi,
Message-ID: <cover.1516202975.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


this patchset is adding minor dt pieces for ep108.
Also adding SPDX headers, fixing minor coding style issue and extending
gem compatible string for all boards.
The next patchset will add much more zynqmp based board.

Thanks,
Michal



Anurag Kumar Vulisha (1):
  arm64: zynqmp: Added OOB timing settings in zynqmp-ep108.dts

Michal Simek (4):
  arm64: zynqmp: Use zynqmp specific compatible string for macb
  arm64: zynqmp: Fix alignment in dts files
  arm64: zynqmp: Add SPDX license identifier
  arm64: zynqmp: Add missing aliases for ep108

P L Sai Krishna (1):
  arm64: zynqmp: Add 8-bit bus width property for ep108

 arch/arm64/boot/dts/xilinx/Makefile              |  1 +
 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi |  1 +
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts      | 18 +++++++++++++++++-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi           | 17 +++++++++--------
 4 files changed, 28 insertions(+), 9 deletions(-)

-- 
1.9.1
