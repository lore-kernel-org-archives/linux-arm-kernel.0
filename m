From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Nov 2011 19:25:09 +0900
Subject: [GIT PULL] Samsung fixes for v3.2
Message-ID: <03e501cca837$d893e320$89bba960$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull samsung-fixes for v3.2 from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
samsung-fixes

This includes fix of inclusion header.
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
samsung-fixes

Axel Lin (1):
      ARM: SAMSUNG: include linux/types.h at gpio-cfg.h

Kukjin Kim (2):
      ARM: S5P: Fix export.h inclusion
      ARM: SAMSUNG: inclusion export.h instead of module.h

Kyungmin Park (1):
      ARM: EXYNOS: Fix compiler error with THIS_MODULE

 arch/arm/mach-exynos/cpuidle.c                |    2 ++
 arch/arm/mach-s3c64xx/mach-crag6410-module.c  |    2 +-
 arch/arm/plat-s3c24xx/cpu-freq-debugfs.c      |    2 +-
 arch/arm/plat-s5p/sysmmu.c                    |    1 +
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |    2 ++
 arch/arm/plat-samsung/pd.c                    |    2 +-
 arch/arm/plat-samsung/pwm.c                   |    2 +-
 7 files changed, 9 insertions(+), 4 deletions(-)
