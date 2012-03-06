From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Mar 2012 02:28:33 -0800
Subject: [GIT PULL] Samsung fixes-4 for v3.3
Message-ID: <4F55E6D1.4080703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull Samsung fixes for v3.3.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:

   Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)

are available in the git repository at:
 
ssh://gitolite at ra.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.3-samsung-fixes-4

Bartlomiej Zolnierkiewicz (1):
       ARM: EXYNOS: fix touchscreen IRQ setup on Universal C210 board

Gusakov Andrey (1):
       ARM: S3C24XX: DMA resume regression fix

Heiko Stuebner (1):
       ARM: S3C24XX: Fix restart on S3C2442

Joonyoung Shim (1):
       ARM: SAMSUNG: Fix memory size for hsotg

  arch/arm/mach-exynos/mach-universal_c210.c |    2 ++
  arch/arm/mach-s3c2440/common.h             |    2 +-
  arch/arm/mach-s3c2440/mach-anubis.c        |    2 +-
  arch/arm/mach-s3c2440/mach-at2440evb.c     |    2 +-
  arch/arm/mach-s3c2440/mach-gta02.c         |    2 +-
  arch/arm/mach-s3c2440/mach-mini2440.c      |    2 +-
  arch/arm/mach-s3c2440/mach-nexcoder.c      |    2 +-
  arch/arm/mach-s3c2440/mach-osiris.c        |    2 +-
  arch/arm/mach-s3c2440/mach-rx1950.c        |    2 +-
  arch/arm/mach-s3c2440/mach-rx3715.c        |    2 +-
  arch/arm/mach-s3c2440/mach-smdk2440.c      |    2 +-
  arch/arm/mach-s3c2440/s3c2440.c            |   13 -------------
  arch/arm/mach-s3c2440/s3c244x.c            |   11 +++++++++++
  arch/arm/plat-s3c24xx/dma.c                |    2 +-
  arch/arm/plat-samsung/devs.c               |    2 +-
  15 files changed, 25 insertions(+), 25 deletions(-)
