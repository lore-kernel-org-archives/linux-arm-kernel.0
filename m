From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 22 Feb 2016 15:33:13 +0530
Subject: [PATCH 0/3] ARM: EXYNOS: Trivial cleanup in mach-exynos
Message-ID: <1456135396-17767-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up mach-exynos files with resepct to unused header file inclusion,
leftover redundant register offset definition. Also corrects comment section at few places.

Pankaj Dubey (3):
  ARM: EXYNOS: correct header comment in Kconfig file
  ARM: EXYNOS: remove unused register offset definition
  ARM: EXYNOS: cleanup header files inclusion

 arch/arm/mach-exynos/Kconfig            | 2 +-
 arch/arm/mach-exynos/common.h           | 1 -
 arch/arm/mach-exynos/exynos.c           | 5 -----
 arch/arm/mach-exynos/firmware.c         | 2 --
 arch/arm/mach-exynos/include/mach/map.h | 9 +--------
 arch/arm/mach-exynos/platsmp.c          | 1 -
 arch/arm/mach-exynos/pm.c               | 4 +---
 arch/arm/mach-exynos/s5p-dev-mfc.c      | 1 -
 8 files changed, 3 insertions(+), 22 deletions(-)

-- 
2.4.5
