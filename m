From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 21 Nov 2014 23:15:26 +0900
Subject: [GIT PULL 1/5] Samsung non-critical fixes for v3.19
Message-ID: <546F48FE.3000601@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-fixes-v3.19

for you to fetch changes up to d4c6c6cf8b42d3e516703c8dc48714fed31859b8:

  ARM: EXYNOS: fix typo in static struct name
"exynos5_list_diable_wfi_wfe" (2014-11-07 08:30:33 +0900)

----------------------------------------------------------------
Samsung non-critical-fixes for v3.19

- fix typo in static struct name "exynos5_list_diable_wfi_wfe"
  : it should be "exynos5_list_disable_wfi_wfe"

----------------------------------------------------------------
Pankaj Dubey (1):
      ARM: EXYNOS: fix typo in static struct name
"exynos5_list_diable_wfi_wfe"

 arch/arm/mach-exynos/pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
