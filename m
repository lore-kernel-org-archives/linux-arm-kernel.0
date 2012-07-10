From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Jul 2012 10:52:30 +0900
Subject: [GIT PULL] Samsung cleanup-1 for v3.6
Message-ID: <0c4901cd5e3e$aa970660$ffc51320$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull samsung cleanup patches for v3.6 and most of them are removing
useless codes.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/cleanup-samsung

Bartlomiej Zolnierkiewicz (1):
      ARM: EXYNOS: Remove leftovers of the Samsung specific power domain
control

Boojin Kim (1):
      ARM: EXYNOS: Remove the L2 cache latency setting for EXYNOS5

Jonghwan Choi (1):
      ARM: SAMSUNG: Remove unused variable 'running' on PWM

Paul Bolle (2):
      ARM: S3C24XX: remove unused header <mach/bast-pmu.h>
      ARM: SAMSUNG: remove unused SPI clock headers

Sachin Kamat (4):
      ARM: S5P64X0: Remove unused variable in dma.c file
      ARM: S5PC100: Remove unused variable in dma.c file
      ARM: SAMSUNG: Remove description corresponding to a deleted element
      ARM: S3C24XX: Remove duplicate header file inclusion

 arch/arm/mach-exynos/common.c                   |   25 ------
 arch/arm/mach-exynos/include/mach/spi-clocks.h  |   16 ----
 arch/arm/mach-exynos/mach-nuri.c                |    1 -
 arch/arm/mach-exynos/mach-origen.c              |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c            |    1 -
 arch/arm/mach-exynos/mach-universal_c210.c      |    1 -
 arch/arm/mach-s3c24xx/common.c                  |    1 -
 arch/arm/mach-s3c24xx/include/mach/bast-pmu.h   |   40 ----------
 arch/arm/mach-s3c64xx/include/mach/spi-clocks.h |   18 ----
 arch/arm/mach-s5p64x0/dma.c                     |    2 -
 arch/arm/mach-s5p64x0/include/mach/spi-clocks.h |   20 -----
 arch/arm/mach-s5pc100/dma.c                     |    2 -
 arch/arm/mach-s5pc100/include/mach/spi-clocks.h |   18 ----
 arch/arm/mach-s5pv210/include/mach/spi-clocks.h |   17 ----
 arch/arm/plat-samsung/Kconfig                   |    8 --
 arch/arm/plat-samsung/Makefile                  |    4 -
 arch/arm/plat-samsung/include/plat/devs.h       |    1 -
 arch/arm/plat-samsung/include/plat/fb.h         |    1 -
 arch/arm/plat-samsung/include/plat/pd.h         |   30 -------
 arch/arm/plat-samsung/pd.c                      |   95
-----------------------
 arch/arm/plat-samsung/pwm.c                     |    4 -
 21 files changed, 0 insertions(+), 306 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/spi-clocks.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/bast-pmu.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/spi-clocks.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/spi-clocks.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/spi-clocks.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/spi-clocks.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/pd.h
 delete mode 100644 arch/arm/plat-samsung/pd.c
