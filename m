From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 21 Nov 2014 23:15:43 +0900
Subject: [GIT PULL 2/5] Samsung 2nd round of cleanup for v3.19
Message-ID: <546F490F.1020601@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 13cfa6c4f7facfc690ba9e99ec382c151fddaced:

  ARM: EXYNOS: Fix CPU idle clock down after CPU off (2014-10-21
00:06:22 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-cleanup-2

for you to fetch changes up to 9c50b2a98cf0ca70480b70a4490a87177519094c:

  ARM: EXYNOS: Remove unused static iomapping (2014-11-13 11:42:59 +0900)

----------------------------------------------------------------
Samsung 2nd cleanup for v3.19

- remove unused static iomapping for exynos SoCs
  : remove unused static iomapping from exynos4/5_iodesc table,
    and related macros from mach/map.h and plat/map-s5p.h.

----------------------------------------------------------------
Pankaj Dubey (1):
      ARM: EXYNOS: Remove unused static iomapping

 arch/arm/mach-exynos/exynos.c                | 50
----------------------------
 arch/arm/mach-exynos/include/mach/map.h      | 23 -------------
 arch/arm/plat-samsung/include/plat/map-s5p.h | 21 ------------
 3 files changed, 94 deletions(-)
