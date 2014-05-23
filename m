From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 May 2014 04:43:22 +0900
Subject: [GIT PULL] Samsung 2nd fixes for 3.15
Message-ID: <537FA4DA.3090600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is 2nd samsung fixes for 3.15, actually it happened before 3.14 but 
would be better if this could be merged into 3.15.

Thanks,
Kukjin


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-2nd-tag

for you to fetch changes up to 68d0e40298f064a5cff40670caded0480274d4b2:

   ARM: dts: Keep LDO4 always ON for exynos5250-arndale board 
(2014-05-20 01:15:46 +0900)

----------------------------------------------------------------
Samsung-fixes-2 for 3.15
- keep LD04 always on for exynos5250-arndale
- fix spi interrupt numbers for exynos5420
- fix ak8975 compatible for exynos4412-trats2

----------------------------------------------------------------
Beomho Seo (1):
       ARM: dts: fix incorrect ak8975 compatible for exynos4412-trats2 board

Sachin Kamat (2):
       ARM: dts: Fix SPI interrupt numbers for exynos5420
       ARM: dts: Keep LDO4 always ON for exynos5250-arndale board

  arch/arm/boot/dts/exynos4412-trats2.dts  | 2 +-
  arch/arm/boot/dts/exynos5250-arndale.dts | 1 +
  arch/arm/boot/dts/exynos5420.dtsi        | 6 +++---
  3 files changed, 5 insertions(+), 4 deletions(-)
