From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri,  9 Oct 2015 00:45:04 +0200
Subject: [PATCH 0/3] Adding Xilinx Zynq 7000 FPGA Manager driver
Message-ID: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this patchset adds support for the Xilinx Zynq 7000 FPGA Manager,
based on Alan's FPGA manager framework.

The patchset has lived for a while already in the Xilinx tree,
however, I don't know if anyone besides me tested it so far?

The version in their tree got ACKs by Michal and Soeren already,
but was based against an older version of Alan's patchset.

Michal, Soeren, could I get ACKs from you guys for this version?

Cheers,

    Moritz

Moritz Fischer (3):
  doc: dt: fpga: Added Documentation for Xilinx Zynq FPGA manager.
  dts: Updated devicetree bindings for Zynq 7000 platform
  fpga manager: Adding FPGA Manager support for Xilinx Zynq 7000

 .../bindings/fpga/xilinx-zynq-fpga-mgr.txt         |  26 ++
 arch/arm/boot/dts/zynq-7000.dtsi                   |   5 +
 drivers/fpga/Kconfig                               |   5 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/zynq-fpga.c                           | 478 +++++++++++++++++++++
 5 files changed, 515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
 create mode 100644 drivers/fpga/zynq-fpga.c

-- 
2.6.1
