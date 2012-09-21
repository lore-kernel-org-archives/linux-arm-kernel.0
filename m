From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Sep 2012 15:21:37 +0900
Subject: [GIT PULL 1/4] Samsung fixes for v3.7
Message-ID: <505C0771.7040103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This is non-critical Samsung fixes for v3.7.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

   Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.7-samsung-fixes-1

Julia Lawall (1):
       ARM: S3C24xx: delete double assignment

Kukjin Kim (1):
       ARM: EXYNOS: fix address for EXYNOS4 MDMA1

Peter Senna Tschudin (1):
       ARM: S3C24XX: removes unnecessary semicolon

Seung-Woo Kim (1):
       ARM: EXYNOS: fixed SYSMMU setup definition to mate parameter name

Sylwester Nawrocki (1):
       ARM: SAMSUNG: Add missing variable declaration in 
s3c64xx_spi1_set_platdata()

  arch/arm/mach-exynos/include/mach/map.h    |    2 +-
  arch/arm/mach-exynos/include/mach/sysmmu.h |    2 +-
  arch/arm/mach-s3c24xx/mach-h1940.c         |    4 ++--
  arch/arm/plat-samsung/devs.c               |    2 ++
  4 files changed, 6 insertions(+), 4 deletions(-)
