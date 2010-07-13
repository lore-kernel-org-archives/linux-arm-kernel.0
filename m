From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Tue, 13 Jul 2010 11:51:27 +0530
Subject: [PATCH 0/3] ab8500-mfd: add regulator support
Message-ID: <1279002090-11234-1-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sundar R Iyer <sundar.iyer@stericsson.com>

Sundar R Iyer (3):
  ab8500-mfd: add regulator support to ab8500 mfd device
  regulator: add support for regulators on the ab8500 MFD
  ux500: add ab8500-regulators machine specific data

 arch/arm/mach-ux500/Makefile                  |    1 +
 arch/arm/mach-ux500/board-mop500-regulators.c |  214 +++++++++++++
 drivers/mfd/ab8500-core.c                     |    4 +-
 drivers/regulator/Kconfig                     |    8 +
 drivers/regulator/Makefile                    |    1 +
 drivers/regulator/ab8500.c                    |  414 +++++++++++++++++++++++++
 include/linux/mfd/ab8500.h                    |    6 +
 include/linux/regulator/ab8500.h              |   25 ++
 8 files changed, 672 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-regulators.c
 create mode 100644 drivers/regulator/ab8500.c
 create mode 100644 include/linux/regulator/ab8500.h
