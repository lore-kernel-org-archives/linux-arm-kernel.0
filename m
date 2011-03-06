From: marvin24@gmx.de (Marc Dietrich)
Date: Sun,  6 Mar 2011 15:31:44 +0100
Subject: [PATCH 0/2] ARM: tegra: Add Toshiba AC100 support
Message-ID: <1299421906-7366-1-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add initial support for the Toshiba AC100 / Dynabook AZ netbook.
The code will not be able to boot the machine as the proprietary bootloader
uses a different machine type (V1 bl: tegra_generic, V2 bl: harmony). Support
for u-boot is being worked on.

The patches are intended for 2.6.40. Depending on the review (and community
progress), I hope to be able to submit more hardware support patches.

Marc Dietrich (2):
  Add initial support for the Toshiba AC100/Dynabook AZ netbook
  Add a default config for PAZ00

 arch/arm/configs/paz00_defconfig         | 1209 ++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/Kconfig              |    5 +
 arch/arm/mach-tegra/Makefile             |    3 +
 arch/arm/mach-tegra/board-paz00-pinmux.c |  157 ++++
 arch/arm/mach-tegra/board-paz00.c        |  128 ++++
 arch/arm/mach-tegra/board-paz00.h        |   22 +
 6 files changed, 1524 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/paz00_defconfig
 create mode 100644 arch/arm/mach-tegra/board-paz00-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.h
