From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Aug 2017 13:36:46 +0200
Subject: [PATCH 0/5] arm64: zynqmp: dtsi changes next
Message-ID: <cover.1501760202.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have cherry-picked others patches from xilinx soc vendor tree which are
ready for submission.
This patchset targets zynqmp.dtsi and ep108 platform.

Thanks,
Michal


Alistair Francis (1):
  arm64: zynqmp: Use C pre-processor for includes

Michal Simek (2):
  arm64: zynqmp: Add fpd/lpd dmas
  arm64: zynqmp: Add missing mmc aliases in ep108

Naga Sureshkumar Relli (1):
  arm64: zynqmp: Enable can1 for ep108

VNSL Durga (1):
  arm64: zynqmp: Added clocks to DT for ep108

 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi |  48 +++++++
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts      |  10 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi           | 165 +++++++++++++++++++++++
 3 files changed, 221 insertions(+), 2 deletions(-)

-- 
1.9.1
