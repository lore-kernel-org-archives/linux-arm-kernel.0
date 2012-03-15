From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Mar 2012 10:28:45 +0000
Subject: Lost fixes?
Message-ID: <20120315102845.GB16389@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These fixes are a collection from other people which resolve various
issues found with the new kautobuilder.  They're now a month old, and
as far as I can see, have not been merged into Linus' tree.

What's the status of them, and when are they going to be merged?

Thanks.

 arch/arm/mach-omap2/Makefile                 |    5 +----
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 +-
 arch/arm/mach-omap2/clock.c                  |    2 +-
 arch/arm/mach-omap2/clock.h                  |    2 +-
 arch/arm/mach-omap2/smartreflex.c            |    2 +-
 arch/arm/plat-omap/clock.c                   |    2 +-
 arch/arm/plat-omap/dma.c                     |    2 +-
 arch/arm/plat-omap/include/plat/clock.h      |    4 ++--
 drivers/cpufreq/Kconfig.arm                  |    6 ++++++
 drivers/cpufreq/Makefile                     |    2 +-
 drivers/mfd/da9052-spi.c                     |    4 ++--
 kernel/irq/chip.c                            |    3 +--
 12 files changed, 19 insertions(+), 17 deletions(-)
