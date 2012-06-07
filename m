From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jun 2012 12:06:10 +0100
Subject: [CFT] OMAP patches
In-Reply-To: <E1Sca9b-0003ax-4E@rmk-PC.arm.linux.org.uk>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
Message-ID: <20120607110610.GB15973@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And the last set - the OMAP patches.

 Documentation/feature-removal-schedule.txt |   11 +
 arch/arm/mach-omap1/board-h2-mmc.c         |    1 -
 arch/arm/mach-omap1/board-h3-mmc.c         |    1 -
 arch/arm/mach-omap1/board-nokia770.c       |    1 -
 arch/arm/mach-omap2/board-n8x0.c           |    1 -
 arch/arm/mach-omap2/hsmmc.c                |    1 -
 arch/arm/plat-omap/include/plat/mmc.h      |    2 -
 drivers/dma/Kconfig                        |    6 +
 drivers/dma/Makefile                       |    1 +
 drivers/dma/omap-dma.c                     |  522 ++++++++++++++++++++++++++++
 drivers/mmc/host/omap.c                    |  368 +++++++++-----------
 drivers/mmc/host/omap_hsmmc.c              |  202 ++++++------
 drivers/mtd/nand/omap2.c                   |  106 +++---
 drivers/spi/spi-omap2-mcspi.c              |  229 +++++++------
 include/linux/omap-dma.h                   |   24 ++
 15 files changed, 1010 insertions(+), 466 deletions(-)
