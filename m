From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 16 Oct 2015 15:42:27 -0700
Subject: [PATCHv2 0/3] Adding FPGA Manager support for Xilinx Zynq
Message-ID: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've tried to address most of the feedback that was brought up,
the one thing I haven't looked at was the firmware format part,
since that was still in discussion.
So I'm still open to suggestions on how to handle this.

In the interest of moving forward, and early feedback I decided
to submit another rev without the firmware format part addressed.

Thanks to all the reviewers of the first round, can we maybe
get ACKs for the docs and devicetree changes?

Cheers,

    Moritz

Moritz Fischer (3):
  ARM: dt: fpga: Added binding docs for Xilinx Zynq FPGA manager.
  ARM: zynq: dt: Updated devicetree for Zynq 7000 platform.
  fpga manager: Adding FPGA Manager support for Xilinx Zynq 7000

 .../bindings/fpga/xilinx-zynq-fpga-mgr.txt         |  19 +
 arch/arm/boot/dts/zynq-7000.dtsi                   |   5 +
 drivers/fpga/Kconfig                               |   5 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/zynq-fpga.c                           | 533 +++++++++++++++++++++
 5 files changed, 563 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
 create mode 100644 drivers/fpga/zynq-fpga.c

-- 
2.4.3
