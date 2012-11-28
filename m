From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 09:15:16 +0900
Subject: [GIT PULL 2/7] Samsung cleanup-3 for v3.8
Message-ID: <50B55794.2050902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

This is for Samsung cleanup for unused codes now.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-samsung-3

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-samsung-3

Thomas Abraham (2):
       ARM: EXYNOS: Remove unused non-dt support for dwmci controller
       ARM: EXYNOS: Remove unused regs-mem.h file

  arch/arm/mach-exynos/Kconfig                 |    5 --
  arch/arm/mach-exynos/Makefile                |    1 -
  arch/arm/mach-exynos/dev-dwmci.c             |   75 
--------------------------
  arch/arm/mach-exynos/include/mach/dwmci.h    |   20 -------
  arch/arm/mach-exynos/include/mach/regs-mem.h |   23 --------
  arch/arm/plat-samsung/include/plat/devs.h    |    1 -
  6 files changed, 0 insertions(+), 125 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/dev-dwmci.c
  delete mode 100644 arch/arm/mach-exynos/include/mach/dwmci.h
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-mem.h
