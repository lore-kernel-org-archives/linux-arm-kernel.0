From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 00:38:57 -0800
Subject: [GIT PULL v2] Samsung board patches for v3.4
Message-ID: <4F5C64A1.1090900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull regarding rebased Samsung board patches without the non-dt 
board file addition for v3.4.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

   Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/board-samsung

Andrzej Pietrasiewicz (2):
       ARM: EXYNOS: Register JPEG on universal_c210
       ARM: EXYNOS: Register JPEG on nuri

Kamil Debski (2):
       ARM: EXYNOS: add G2D to mach-nuri
       ARM: EXYNOS: add G2D to mach-universal

Mark Brown (8):
       ARM: S3C64XX: Support GPIO LEDs on Cragganmore
       ARM: S3C64XX: Fix build of Cragganmore after SPI changes
       ARM: S3C64XX: Enable power management for disk on Cragganmore
       ARM: S3C64XX: Enable power management for WiFi on Cragganmore
       ARM: S3C64XX: Add hookup for Tomatin module on Cragganmore
       ARM: S3C64XX: Add a SPKVDD supply for CODECs on Cragganmore
       ARM: S3C64XX: Add some more Cragganmore module IDs to the table
       ARM: S3C64XX: Supply platform data for SPI on Cragganmore

MyungJoo Ham (1):
       ARM: EXYNOS: support Exynos4210-bus Devfreq driver on Nuri board

Sachin Kamat (13):
       ARM: EXYNOS: Enable G2D on ORIGEN
       ARM: S5PV210: Add missing FIMC media device to Aquila
       ARM: EXYNOS: Add missing FIMC media device to SMDKV310
       ARM: EXYNOS: Add missing FIMC media device to Origen
       ARM: EXYNOS: Enable G2D on SMDKV310
       ARM: S5PV210: Enable MFC on SMDKV210
       ARM: S5PV210: Enable MFC on SMDKC110
       ARM: S5PV210: Enable FIMC on SMDKV210
       ARM: S5PV210: Enable FIMC on SMDKC110
       ARM: EXYNOS: Enable JPEG on SMDKV310
       ARM: EXYNOS: Enable JPEG on Origen
       ARM: S5PV210: Add JPEG board definition
       ARM: S5PV210: Enable JPEG on SMDKV210

Sangwook Lee (1):
       ARM: EXYNOS: Enable Bluetooth on ORIGEN

Sylwester Nawrocki (3):
       ARM: EXYNOS: Increase virtual framebuffer size on Universal C210 
board
       ARM: EXYNOS: Add support for S5K6AAFX image sensor on Universal 
C210 board
       ARM: SAMSUNG: Add support for S5K6AAFX camera on Nuri board

Tushar Behera (2):
       ARM: EXYNOS: Add __init attribute to nuri_camera_init()
       ARM: EXYNOS: Add __init attribute to universal_camera_init()

  arch/arm/mach-exynos/Kconfig                 |   10 +++
  arch/arm/mach-exynos/mach-nuri.c             |   80 
++++++++++++++++++++++++-
  arch/arm/mach-exynos/mach-origen.c           |   37 ++++++++++++
  arch/arm/mach-exynos/mach-smdkv310.c         |    3 +
  arch/arm/mach-exynos/mach-universal_c210.c   |   80 
++++++++++++++++++++++++--
  arch/arm/mach-s3c64xx/Kconfig                |    1 +
  arch/arm/mach-s3c64xx/mach-crag6410-module.c |   31 ++++++++++-
  arch/arm/mach-s3c64xx/mach-crag6410.c        |   67 +++++++++++++++++++++-
  arch/arm/mach-s5pv210/Kconfig                |    9 +++
  arch/arm/mach-s5pv210/clock.c                |    5 ++
  arch/arm/mach-s5pv210/include/mach/map.h     |    4 +
  arch/arm/mach-s5pv210/mach-aquila.c          |    1 +
  arch/arm/mach-s5pv210/mach-smdkc110.c        |   14 +++++
  arch/arm/mach-s5pv210/mach-smdkv210.c        |   15 +++++
  14 files changed, 346 insertions(+), 11 deletions(-)
