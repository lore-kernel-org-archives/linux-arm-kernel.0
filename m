From: atull@opensource.altera.com (Alan Tull)
Date: Tue, 12 Jul 2016 14:07:07 -0500
Subject: [PATCH 0/2] FPGA Manager support for Arria10
Message-ID: <20160712190709.5964-1-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New patch submission for FPGA Manager support for the Altera
SoCFPGA Arria10 plus device tree bindings.

Alan Tull (2):
  ARM: socfpga: add bindings doc for arria10 fpga manager
  fpga-manager: Add Socfpga Arria10 support

 .../bindings/fpga/altera-socfpga-a10-fpga-mgr.txt  |  19 +
 drivers/fpga/Kconfig                               |   6 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/socfpga-a10.c                         | 573 +++++++++++++++++++++
 4 files changed, 599 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-socfpga-a10-fpga-mgr.txt
 create mode 100644 drivers/fpga/socfpga-a10.c

-- 
2.9.1
