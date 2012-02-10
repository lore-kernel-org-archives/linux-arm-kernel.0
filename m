From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Feb 2012 21:39:01 +0900
Subject: [GIT PULL] Samsung regarding board developing for v3.4
Message-ID: <013a01cce7f0$f71e57f0$e55b07d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull regarding board patches for samsung from following:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/board-samsung

This is including S3C64XX Cragganmore, EXYNOS4 SMDKV310, Origen boards and
so on.

As a note, there is no conflict with merging arm-soc/depends/rmk/for-armsoc.
And I will send other board specific branch later again. This is a just
first next/board branch for v3.4.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/board-samsung

Kamil Debski (2):
      ARM: EXYNOS: add G2D to mach-nuri
      ARM: EXYNOS: add G2D to mach-universal

Mark Brown (6):
      ARM: S3C64XX: Support GPIO LEDs on Cragganmore
      ARM: S3C64XX: Fix build of Cragganmore after SPI changes
      ARM: S3C64XX: Enable power management for disk on Cragganmore
      ARM: S3C64XX: Enable power management for WiFi on Cragganmore
      ARM: S3C64XX: Add hookup for Tomatin module on Cragganmore
      ARM: S3C64XX: Add a SPKVDD supply for CODECs on Cragganmore

Sachin Kamat (4):
      ARM: EXYNOS: Enable G2D on ORIGEN
      ARM: S5PV210: Add missing FIMC media device to Aquila
      ARM: EXYNOS: Add missing FIMC media device to SMDKV310
      ARM: EXYNOS: Add missing FIMC media device to Origen

Sangwook Lee (1):
      ARM: EXYNOS: Enable Bluetooth on ORIGEN

Sylwester Nawrocki (3):
      ARM: EXYNOS: Increase virtual framebuffer size on Universal C210 board
      ARM: EXYNOS: Add support for S5K6AAFX image sensor on Universal C210
board
      ARM: SAMSUNG: Add support for S5K6AAFX camera on Nuri board

 arch/arm/mach-exynos/Kconfig                 |    5 ++
 arch/arm/mach-exynos/mach-nuri.c             |   66 ++++++++++++++++++++++
 arch/arm/mach-exynos/mach-origen.c           |   36 ++++++++++++
 arch/arm/mach-exynos/mach-smdkv310.c         |    1 +
 arch/arm/mach-exynos/mach-universal_c210.c   |   77
++++++++++++++++++++++++-
 arch/arm/mach-s3c64xx/Kconfig                |    1 +
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   27 +++++++++-
 arch/arm/mach-s3c64xx/mach-crag6410.c        |   67 ++++++++++++++++++++++-
 arch/arm/mach-s5pv210/mach-aquila.c          |    1 +
 9 files changed, 275 insertions(+), 6 deletions(-)
