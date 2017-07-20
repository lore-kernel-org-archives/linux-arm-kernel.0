From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:16:59 +0200
Subject: [PATCH 00/10] arm64: zynqmp: dtsi changes
Message-ID: <cover.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have cherry-picked all patches from xilinx soc vendor tree which are
ready for submission.
This patchset targets only zynqmp.dtsi which is shared with all zynqmp
families.

Thanks,
Michal


Bharat Kumar Gogada (1):
  arm64: zynqmp: Adding prefetchable memory space to pcie node

Edgar E. Iglesias (1):
  arm64: zynqmp: Correct IRQ nr for the SMMU

Michal Simek (5):
  arm64: zynqmp: Add references to cpu nodes
  arm64: zynqmp: Add dcc console for zynqmp
  arm64: zynqmp: Add CCI-400 node
  arm64: zynqmp: Add support for RTC
  arm64: zynqmp: Add new uartps compatible string

Naga Sureshkumar Relli (1):
  arm64: zynqmp: Set status disabled in dtsi

Shubhrajyoti Datta (1):
  arm64: zynqmp: Add operating points

Stefan Krsmanovic (1):
  arm64: zynqmp: Add idle state for ZynqMP

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 111 ++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 17 deletions(-)

-- 
1.9.1
