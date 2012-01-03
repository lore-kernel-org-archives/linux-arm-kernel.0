From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 04 Jan 2012 08:30:03 +0900
Subject: [GIT PULL] Samsung cleanup for v3.3
Message-ID: <018701ccca6f$9e6f80f0$db4e82d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull Samsung cleanup for v3.3 from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-cleanup-samsung

There are cleanups for Samsung stuff and there is no dependency with other
branches.

Sorry for late, I thought sent 'pull request' this :( if any problems,
please let me know.

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
next-samsung-cleanup-samsung

Jingoo Han (2):
      ARM: S5PV210: Use gpio_request_one
      ARM: EXYNOS: Use gpio_request_one

Shawn Guo (1):
      ARM: EXYNOS: remove exynos4_scu_enable()

Thomas Meyer (1):
      ARM: SAMSUNG: Use kmemdup rather than duplicating its implementation

 arch/arm/mach-exynos/mach-nuri.c           |    9 ++-------
 arch/arm/mach-exynos/mach-smdkv310.c       |    4 +---
 arch/arm/mach-exynos/mach-universal_c210.c |   10 +++-------
 arch/arm/mach-exynos/pm.c                  |   24 ++----------------------
 arch/arm/mach-s5pv210/mach-aquila.c        |    3 +--
 arch/arm/mach-s5pv210/mach-goni.c          |    6 ++----
 arch/arm/mach-s5pv210/mach-smdkv210.c      |   10 +++-------
 arch/arm/plat-s3c24xx/dma.c                |    3 +--
 8 files changed, 15 insertions(+), 54 deletions(-)
