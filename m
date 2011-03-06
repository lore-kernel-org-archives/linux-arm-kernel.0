From: marvin24@gmx.de (Marc Dietrich)
Date: Sun, 6 Mar 2011 18:50:39 +0100
Subject: [PATCH v2 0/2] ARM: tegra: Add Toshiba AC100 support
Message-ID: <cover.1299433839.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich (2):
  Add initial support for the Toshiba AC100/Dynabook AZ netbook
  Add PAZ00 to tegra_defconfig

 arch/arm/configs/tegra_defconfig         |    1 +
 arch/arm/mach-tegra/Kconfig              |    5 +
 arch/arm/mach-tegra/Makefile             |    3 +
 arch/arm/mach-tegra/board-paz00-pinmux.c |  157 ++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.c        |  128 ++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h        |   22 ++++
 6 files changed, 316 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-paz00-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.h
