From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 25 Feb 2016 09:39:58 +0530
Subject: [PATCH v2 0/2] ARM: EXYNOS: Trivial cleanup samsung mach files
Message-ID: <1456373400-10633-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up mach-exynos, mach-s3c24xx, plat-samsung include
header files with resepct to unused header file inclusion, removes redundant
register offset definition. Also corrects comment section at few places.

Changes since v1:
 - Keeping back inclusion of header "platform_device.h" in exynos.c.
 - Removing all unused instances of S3C_UART_OFFSET from mach-exynos,
   mach-s3c24xx, and plat-samsung, in single patch.
 - Patch 1/3 is already merged in maintainer tree so not included in v2. 

Pankaj Dubey (2):
  ARM: EXYNOS: cleanup header files inclusion
  ARM: SAMSUNG: remove unused register offset definition

 arch/arm/mach-exynos/common.h                |  1 -
 arch/arm/mach-exynos/exynos.c                |  4 ----
 arch/arm/mach-exynos/firmware.c              |  2 --
 arch/arm/mach-exynos/include/mach/map.h      |  9 +--------
 arch/arm/mach-exynos/platsmp.c               |  1 -
 arch/arm/mach-exynos/pm.c                    |  4 +---
 arch/arm/mach-exynos/s5p-dev-mfc.c           |  1 -
 arch/arm/mach-s3c24xx/include/mach/map.h     | 11 -----------
 arch/arm/plat-samsung/include/plat/map-s3c.h |  4 ----
 arch/arm/plat-samsung/include/plat/map-s5p.h |  5 -----
 10 files changed, 2 insertions(+), 40 deletions(-)

-- 
2.4.5
