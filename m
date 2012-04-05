From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 05 Apr 2012 08:30:23 -0700
Subject: [GIT PULL] Samsung fixes-1 for v3.4
Message-ID: <4F7DBA8F.2010903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull samsung-fixes-1 for v3.4 from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.4-samsung-fixes-1

They are for fix uart stuff on exynos, build warning and omission file 
happened during resolving merge conflict on s3c24xx.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

   Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.4-samsung-fixes-1

Colin Cross (1):
       ARM: EXYNOS: fix CONFIG_DEBUG_LL

Dima Zavin (1):
       ARM: EXYNOS: use chip_id reg in uncompress to select uart base phys

Il Han (1):
       ARM: EXYNOS: fix ISO C90 warning

Kukjin Kim (1):
       ARM: S3C24XX: fix missing common.h in mach-s3c24xx/

Sachin Kamat (1):
       ARM: EXYNOS: Fix compiler warning in dma.c file

  arch/arm/mach-exynos/common.c                   |    3 ++-
  arch/arm/mach-exynos/dma.c                      |    2 --
  arch/arm/mach-exynos/include/mach/debug-macro.S |    7 +++----
  arch/arm/mach-exynos/include/mach/uncompress.h  |   17 ++++++++++++++++-
  arch/arm/mach-s3c24xx/common.h                  |   18 ++++++++++++++++++
  5 files changed, 39 insertions(+), 8 deletions(-)
  create mode 100644 arch/arm/mach-s3c24xx/common.h
