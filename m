From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  4 Mar 2011 22:44:26 -0700
Subject: [PATCH 0/3] ARM: Tegra: Enable audio (boards-for-next)
Message-ID: <1299303869-7827-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the subset of patches to enable audio on Tegra Harmony that can be
immediately applied to Olof's boards-for-next branch.

Stephen Warren (3):
  ARM: Tegra: Add devices.c entries for audio
  ARM: Tegra: Create defines for SD-related GPIO names
  ARM: tegra: Harmony: Beginnings of audio support

 arch/arm/mach-tegra/board-harmony-pinmux.c  |   28 ++++++-----
 arch/arm/mach-tegra/board-harmony.c         |   38 ++++++++++++--
 arch/arm/mach-tegra/board-harmony.h         |   14 +++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c |   10 ++--
 arch/arm/mach-tegra/board-seaboard.c        |    6 +-
 arch/arm/mach-tegra/board-seaboard.h        |    3 +
 arch/arm/mach-tegra/devices.c               |   70 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/devices.h               |    4 ++
 arch/arm/mach-tegra/include/mach/iomap.h    |    3 +
 9 files changed, 150 insertions(+), 26 deletions(-)
