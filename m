From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 13 Jun 2013 09:37:14 -0700
Subject: [PATCH v3 0/4] Zynq: Support more boards
Message-ID: <1371141438-16553-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just another respin. Still depending on armsoc/zynq/clk

	S?ren

v3:
 - adding patch to use 'status' property for UART nodes
 - dropping board specific compat string in the Zed dts

v2:
 - adding patch to remove board specific compat strings from the BSP
 - adding patch adding Zed support

Soren Brinkmann (4):
  arm: zynq: Remove board specific compatibility string
  arm: dt: zynq: Use 'status' property for UART nodes
  arm: dt: zynq: Add support for the zc706 platform
  arm: dt: zynq: Add support for the zed platform

 arch/arm/boot/dts/Makefile       |  4 +++-
 arch/arm/boot/dts/zynq-7000.dtsi |  2 ++
 arch/arm/boot/dts/zynq-zc702.dts |  6 +++++-
 arch/arm/boot/dts/zynq-zc706.dts | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zed.dts   | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-zynq/common.c      |  1 -
 6 files changed, 80 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-zc706.dts
 create mode 100644 arch/arm/boot/dts/zynq-zed.dts

-- 
1.8.3
