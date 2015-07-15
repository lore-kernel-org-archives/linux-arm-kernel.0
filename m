From: wendy.liang@xilinx.com (Wendy Liang)
Date: Wed, 15 Jul 2015 05:22:53 -0700
Subject: [RFC PATCH 0/2] remoteproc: Add zynqmp R5 remoteproc driver
Message-ID: <1436962975-13918-1-git-send-email-jliang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is to add remoteproc driver for Cortex-R5
included in Xilinx Zynq UltraScale MPSoC so that we can
boot and passing messages to the R5 subsystem.

Wendy Liang (2):
  remoteproc: Add zynqmp R5 remoteproc driver
  Documentation: DTS: bindings: add ZynqMP RPU remoteproc

 .../bindings/remoteproc/zynqmp_r5_remoteproc.txt   |  49 ++
 drivers/remoteproc/Kconfig                         |   9 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c          | 809 +++++++++++++++++++++
 4 files changed, 868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/zynqmp_r5_remoteproc.txt
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.1.1
