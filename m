From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  4 Mar 2011 22:42:27 -0700
Subject: [PATCH 0/5] ARM: Tegra: Enable audio (boards-for-next-i2c)
Message-ID: <1299303752-7779-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the complete patch series to enable audio on Tegra Harmony, based
on Olof's boards-for-next-i2c branch.

Stephen Warren (5):
  ARM: Tegra: Add devices.c entries for audio
  ARM: Tegra: Create defines for SD-related GPIO names
  ARM: tegra: Harmony: Beginnings of audio support
  ARM: tegra: Harmony: I2C-related portions of audio support
  ARM: tegra: Harmony: Set WM8903 gpio_base

 arch/arm/mach-tegra/board-harmony-pinmux.c  |   28 ++++++-----
 arch/arm/mach-tegra/board-harmony.c         |   61 +++++++++++++++++++++--
 arch/arm/mach-tegra/board-harmony.h         |   14 +++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c |   12 ++--
 arch/arm/mach-tegra/board-seaboard.c        |    6 +-
 arch/arm/mach-tegra/board-seaboard.h        |    3 +
 arch/arm/mach-tegra/devices.c               |   70 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/devices.h               |    4 ++
 arch/arm/mach-tegra/include/mach/iomap.h    |    3 +
 9 files changed, 174 insertions(+), 27 deletions(-)
