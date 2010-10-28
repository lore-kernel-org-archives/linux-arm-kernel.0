From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 28 Oct 2010 14:25:07 +0200
Subject: [PATCH v3 0/2] add support for the Marvell Dove SDHCI controller
Message-ID: <cover.1288268453.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the Marvell Dove SDHCI controller.

v3 changes:
* finally remove unneeded includes from the driver

v2 changes:
* rename drivers/mmc/host/sdhci-mv.c to drivers/mmc/host/sdhci-dove.c and
update Kconfig and Makefile respectively
* add dependancy on ARCH_DOVE
* remove unneeded includes from the driver

Mike Rapoport (2):
  MMC: add support for the Marvell Dove SDHCI controller
  [ARM] Dove: rename SDCHI devices to "sdhci-dove"

 arch/arm/mach-dove/common.c    |    4 +-
 drivers/mmc/host/Kconfig       |   13 +++++++
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sdhci-dove.c  |   70 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c |    3 ++
 drivers/mmc/host/sdhci-pltfm.h |    1 +
 6 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-dove.c

-- 
1.7.3.1
