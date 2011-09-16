From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Sep 2011 12:27:49 +0200
Subject: [PATCH 0/4] ARM: Samsung: Add board setup for M-5MOLS and NOON010PC30
	camera sensors
Message-ID: <1316168873-22257-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following patch series adds board setup code for NOOON01PC30 sensor
on GONI and M-5MOLS on UNIVERSAL_C210 board.
Some clocks are modified in line with latest FIMC driver modifcations for v3.2.

Sylwester Nawrocki (4):
  ARM: S5PV210: Rename sclk_cam clocks for FIMC media driver
  ARM: S5PV210: Add support for NOON010PC30 sensor on GONI board
  ARM: EXYNOS4: Rename sclk_cam clocks for FIMC driver
  ARM: S5PV210: UNIVERSAL_C210: Add support for M-5MOLS image sensor

 arch/arm/mach-exynos4/Kconfig               |    3 +
 arch/arm/mach-exynos4/clock.c               |    6 +-
 arch/arm/mach-exynos4/mach-universal_c210.c |  211 ++++++++++++++++++++++++++-
 arch/arm/mach-s5pv210/Kconfig               |    1 +
 arch/arm/mach-s5pv210/clock.c               |    6 +-
 arch/arm/mach-s5pv210/mach-goni.c           |   53 +++++++
 6 files changed, 264 insertions(+), 16 deletions(-)

Created against samsung-for-next branch at git://github.com/kgene/linux-samsung.git
on top of the HDMI board patches from Tomasz Stanislawski.

The patches can be pulled from git://git.infradead.org/users/kmpark/linux-2.6-samsung, 
branch samsung-board-camera.


Thanks,
--
Sylwester Nawrocki
Samsung Poland R&D Center
