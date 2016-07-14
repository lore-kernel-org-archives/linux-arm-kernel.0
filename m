From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 14 Jul 2016 11:06:38 -0500
Subject: [PATCH 00/10] Add NAND, DMA, USB, and QSPI EDAC
Message-ID: <1468512408-5156-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch series adds the NAND, DMA, USB and QSPI FIFO EDAC modules.

Thor Thayer (10):
  Documentation: dt: socfpga: Add Arria10 NAND EDAC binding
  Documentation: dt: socfpga: Add Arria10 DMA EDAC binding
  Documentation: dt: socfpga: Add Arria10 USB EDAC binding
  Documentation: dt: socfpga: Add Arria10 QSPI EDAC binding
  EDAC, altera: Add Arria10 NAND EDAC support
  EDAC, altera: Add Arria10 DMA EDAC support
  EDAC, altera: Add Arria10 USB EDAC support
  EDAC, altera: Add Arria10 QSPI EDAC support
  ARM: dts: Add Arria10 DMA EDAC devicetree entry
  ARM: dts: Add Arria10 USB EDAC devicetree entry

 .../bindings/arm/altera/socfpga-eccmgr.txt         |   79 ++++++++++++
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   16 +++
 drivers/edac/Kconfig                               |   28 +++++
 drivers/edac/altera_edac.c                         |  130 +++++++++++++++++++-
 4 files changed, 252 insertions(+), 1 deletion(-)

-- 
1.7.9.5
