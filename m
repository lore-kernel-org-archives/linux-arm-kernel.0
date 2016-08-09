From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 9 Aug 2016 09:40:50 -0500
Subject: [PATCHv2 0/3] Add SD/MMC EDAC for Altera Arria10
Message-ID: <1470753653-23465-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the SD/MMC FIFO EDAC module which is a dual-port RAM as
opposed to the other Arria10 peripheral's single port RAM FIFOs.

Thor Thayer (3):
  Documentation: dt: socfpga: Add Arria10 SD-MMC EDAC binding
  EDAC, altera: Add Arria10 SD-MMC EDAC support
  ARM: dts: Add Arria10 SD/MMC EDAC devicetree entry

 .../bindings/arm/altera/socfpga-eccmgr.txt         |   19 ++
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts  |   12 ++
 drivers/edac/Kconfig                               |    7 +
 drivers/edac/altera_edac.c                         |  188 +++++++++++++++++++-
 drivers/edac/altera_edac.h                         |    5 +
 5 files changed, 230 insertions(+), 1 deletion(-)

-- 
1.7.9.5
