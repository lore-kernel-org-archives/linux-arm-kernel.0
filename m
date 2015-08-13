From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 14 Aug 2015 03:51:40 +0900
Subject: [GIT PULL v2 3/5] Samsung SoC updates for v4.3
In-Reply-To: <55CCE517.2070003@kernel.org>
References: <55CCE517.2070003@kernel.org>
Message-ID: <55CCE73C.3080404@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-soc

for you to fetch changes up to bdd2648e50508cbb2eb6d1c303e4d2d6d7505400:

  ARM: EXYNOS: switch to using generic cpufreq driver for exynos4x12
(2015-08-14 03:07:10 +0900)

----------------------------------------------------------------
Samsung SoC updates for v4.3

- add compatible string to exynos_cpufreq_matchs to switch for
  supporting generic cpufreq driver for exynos3250, 4210, 4212
  and 5250 SoCs in mach-exynos/

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: EXYNOS: switch to using generic cpufreq driver for exynos4x12

Chanwoo Choi (1):
      ARM: EXYNOS: Add exynos3250 compatible to use generic cpufreq driver

Thomas Abraham (1):
      ARM: EXYNOS: switch to using generic cpufreq driver for exynos5250

 arch/arm/mach-exynos/Kconfig  | 2 ++
 arch/arm/mach-exynos/exynos.c | 4 ++++
 2 files changed, 6 insertions(+)
