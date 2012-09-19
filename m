From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:19:15 +0900
Subject: [GIT PULL 6/7] Samsung cleanup fimd header for v3.7
Message-ID: <099d01cd96bd$2f625050$8e26f0f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof.

This is for moving header file is related to fimd from platform to
include/video.

Since this touches many Samsung stuff, it is included in samsung tree and I
requested to pull into Florian's tree and he already agreed. So its name is
'v3.7-for-florian'.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.7-for-florian

Leela Krishna Amudala (2):
      include/video: move fimd register headers from platform to
include/video
      include/video: Add register offsets for FIMD version 8

 arch/arm/mach-exynos/mach-nuri.c                   |    2 +-
 arch/arm/mach-exynos/mach-origen.c                 |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c               |    2 +-
 arch/arm/mach-exynos/mach-smdkv310.c               |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c         |    2 +-
 arch/arm/mach-exynos/setup-fimd0.c                 |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +-
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159
--------------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +-
 drivers/video/s3c-fb.c                             |    2 +-
 .../plat/regs-fb.h => include/video/samsung_fimd.h |  152
+++++++++++++++++--
 26 files changed, 165 insertions(+), 194 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
 rename arch/arm/plat-samsung/include/plat/regs-fb.h =>
include/video/samsung_fimd.h (73%)
