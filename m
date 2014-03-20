From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Mar 2014 07:29:48 +0900
Subject: [GIT PULL 1/4] Samsung 3rd cleanup for v3.15
Message-ID: <532B6BDC.6040806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 19a964644f1e655c3f67d539c1e99a9fbcc4588c:

   ARM: SAMSUNG: remove all custom uncompress.h (2014-03-11 22:05:18 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-cleanup-3

for you to fetch changes up to 1aa9c483d1be13831bc4e516ce4848d32ac3e944:

   ARM: EXYNOS: Remove hardware.h file (2014-03-21 04:49:03 +0900)

----------------------------------------------------------------
Samsung 3rd cleanup for v3.15

- Remove <mach/hardware.h> in mach-exynos
- Remove invalid code from <mach/hardware.h> in mach-s3c24xx

Note that this is based on previous tags/samsung-cleanup-2

----------------------------------------------------------------
Sachin Kamat (3):
       ARM: S3C24XX: Remove invalid code from hardware.h
       ARM: SAMSUNG: Remove hardware.h inclusion
       ARM: EXYNOS: Remove hardware.h file

  arch/arm/mach-exynos/include/mach/hardware.h  | 18 ------------------
  arch/arm/mach-exynos/platsmp.c                |  2 --
  arch/arm/mach-s3c24xx/include/mach/hardware.h | 14 +-------------
  arch/arm/plat-samsung/clock.c                 |  1 -
  arch/arm/plat-samsung/devs.c                  |  2 +-
  arch/arm/plat-samsung/init.c                  |  2 --
  arch/arm/plat-samsung/pm.c                    |  1 -
  arch/arm/plat-samsung/s5p-dev-uart.c          |  1 -
  8 files changed, 2 insertions(+), 39 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/include/mach/hardware.h
