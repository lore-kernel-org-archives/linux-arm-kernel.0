From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 01:03:41 -0800
Subject: [GIT PULL v2 4/4] Samsung devel-dma for v3.4
Message-ID: <4F5C6A6D.9010400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I rebased devel-samsung-dma on top of new next-exynos-clock as per 
Olof's suggestion.

Please pull it from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung-dma

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 44b2cef5ae6da48523fa634230ca66107110a7dd:

   ARM: EXYNOS: Add clock register addresses for EXYNOS4X12 bus devfreq 
driver (2012-03-10 22:30:32 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung-dma

Boojin Kim (2):
       ARM: EXYNOS: Enable MDMA driver
       ARM: EXYNOS: add support DMA for EXYNOS4X12 SoC

Tushar Behera (1):
       ARM: EXYNOS: Add apb_pclk clkdev entry for mdma1

  arch/arm/mach-exynos/Kconfig                   |    3 +
  arch/arm/mach-exynos/clock-exynos4.c           |    9 ++
  arch/arm/mach-exynos/dma.c                     |  117 
++++++++++++++++++++++--
  arch/arm/mach-exynos/include/mach/irqs.h       |    2 +
  arch/arm/mach-exynos/include/mach/map.h        |    3 +-
  arch/arm/plat-samsung/include/plat/dma-pl330.h |   16 +++
  6 files changed, 141 insertions(+), 9 deletions(-)
