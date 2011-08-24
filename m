From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Aug 2011 22:25:47 +0900
Subject: [PATCH 0/5] ARM: EXYNOS4: Add support new EXYNOS4212 SoC
Message-ID: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support new EXYNOS4212 SoC and SMDK4212 Board.

[PATCH 1/5] ARM: EXYNOS4: Add support new EXYNOS4212 SoC
[PATCH 2/5] ARM: EXYNOS4: Add support clock for EXYNOS4212
[PATCH 3/5] ARM: EXYNOS4: Add support PM for EXYNOS4212
[PATCH 4/5] ARM: EXYNOS4: Add support SMDK4212 Board
[PATCH 5/5] tty: Add support serial for EXYNOS4212 SoC

 arch/arm/mach-exynos4/Kconfig                      |   30 ++
 arch/arm/mach-exynos4/Makefile                     |    8 +-
 arch/arm/mach-exynos4/clock-exynos4210.c           |  139 ++++++++++
 arch/arm/mach-exynos4/clock-exynos4212.c           |  118 ++++++++
 arch/arm/mach-exynos4/clock.c                      |  218 ++++++++++-----
 arch/arm/mach-exynos4/cpu.c                        |   12 +-
 arch/arm/mach-exynos4/include/mach/exynos4-clock.h |   43 +++
 arch/arm/mach-exynos4/include/mach/regs-clock.h    |   54 +++--
 arch/arm/mach-exynos4/mach-smdk4212.c              |  292 ++++++++++++++++++++
 arch/arm/mach-exynos4/pm.c                         |   79 +-----
 arch/arm/plat-s5p/cpu.c                            |    9 +
 arch/arm/plat-s5p/include/plat/exynos4.h           |    5 +-
 arch/arm/plat-s5p/include/plat/pll.h               |   55 ++++-
 arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
 drivers/tty/serial/Kconfig                         |    4 +-
 15 files changed, 903 insertions(+), 171 deletions(-)
