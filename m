From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 09:15:48 +0900
Subject: [GIT PULL 4/7] Samsung cam for v3.8
Message-ID: <50B557B4.3090109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

This is including update Samsung cam for v3.8

Just adding camif gpio setup and clkdev.

Pleases pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cam-samsung

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cam-samsung

Sylwester Nawrocki (2):
       ARM: SAMSUNG: Add s3c24xx/s3c64xx CAMIF GPIO setup helpers
       ARM: S3C24XX: Add clkdev entry for camif-upll clock

  arch/arm/mach-s3c24xx/Kconfig         |    1 +
  arch/arm/mach-s3c24xx/clock-s3c2440.c |    1 +
  arch/arm/plat-samsung/Kconfig         |    5 ++
  arch/arm/plat-samsung/Makefile        |    1 +
  arch/arm/plat-samsung/setup-camif.c   |   70 
+++++++++++++++++++++++++++++++++
  5 files changed, 78 insertions(+), 0 deletions(-)
  create mode 100644 arch/arm/plat-samsung/setup-camif.c
