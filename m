From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 7 Sep 2018 09:57:01 +0200
Subject: [GIT PULL] arm64: zynqmp: Xilinx SoC changes for v4.20
Message-ID: <5e9c248d-c19c-1881-f406-d7bfd38ec479@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull the following firmware interface to your tree.

Thanks,
Michal


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-v4.20

for you to fetch changes up to bca7067d2d4e91f58162b07d73cd94e20437b4f6:

  firmware: xilinx: Add debugfs for query data API (2018-09-07 09:44:44
+0200)

----------------------------------------------------------------
arm64: zynqmp: SoC changes for v4.20

- Adding firmware API for SoC with debugfs interface

----------------------------------------------------------------
Rajan Vaja (8):
      dt-bindings: firmware: Add bindings for ZynqMP firmware
      firmware: xilinx: Add Zynqmp firmware driver
      firmware: xilinx: Add zynqmp IOCTL API for device control
      firmware: xilinx: Add query data API
      firmware: xilinx: Add clock APIs
      firmware: xilinx: Add debugfs interface
      firmware: xilinx: Add debugfs for IOCTL API
      firmware: xilinx: Add debugfs for query data API

 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt |  29 +++++++
 arch/arm64/Kconfig.platforms
   |   1 +
 drivers/firmware/Kconfig
   |   1 +
 drivers/firmware/Makefile
   |   1 +
 drivers/firmware/xilinx/Kconfig
   |  23 ++++++
 drivers/firmware/xilinx/Makefile
   |   5 ++
 drivers/firmware/xilinx/zynqmp-debug.c
   | 249 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h
   |  22 ++++++
 drivers/firmware/xilinx/zynqmp.c
   | 562
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h
   | 115 +++++++++++++++++++++++++++
 10 files changed, 1008 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h
