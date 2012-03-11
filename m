From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 00:56:14 -0800
Subject: [GIT PULL v2 3/4] Samsung devel-mmc for v3.4
Message-ID: <4F5C68AE.4000101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull Samsung devel-mmc for v3.4 and I rebased it on top of 
v3.3-rc7 without v3.4-for-cjb.

Please pull it from:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung-mmc

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

   Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung-mmc

Jaehoon Chung (3):
       ARM: SAMSUNG: support the second capability for samsung-soc
       mmc: sdhci-s3c: add platform data for the second capability
       ARM: SAMSUNG: change the name from s3c-sdhci to exynos4-sdhci

  arch/arm/mach-exynos/mach-nuri.c           |    4 ++--
  arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
  arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
  arch/arm/plat-samsung/platformdata.c       |    2 ++
  drivers/mmc/host/sdhci-s3c.c               |    6 +++---
  5 files changed, 10 insertions(+), 6 deletions(-)
