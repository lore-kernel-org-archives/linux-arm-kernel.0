From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 4 Apr 2017 14:55:44 +0530
Subject: [GIT PULL 1/4] DaVinci driver updates for v4.12
Message-ID: <20170404092547.32480-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/drivers

for you to fetch changes up to 396ff64d44dbcbd4e6c06c005c4e931bd4b35e4d:

  pata_bk3710: clear status bits of BMISP on chipset initialization (2017-03-30 16:13:04 +0530)

----------------------------------------------------------------
This adds a new driver for PalmChip
PATA controller found on DM6446 and
DM6467 SoCs. This should eventually
replace the driver in IDE subsystem.

The patches have been acked by ATA
maintainer.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (3):
      ata: add Palmchip BK3710 PATA controller driver
      pata_bk3710: disable IORDY Timer on chipset initialization
      pata_bk3710: clear status bits of BMISP on chipset initialization

 drivers/ata/Kconfig       |   9 ++
 drivers/ata/Makefile      |   1 +
 drivers/ata/pata_bk3710.c | 382 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 drivers/ata/pata_bk3710.c
