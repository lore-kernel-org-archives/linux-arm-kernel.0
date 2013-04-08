From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:19:24 +0900
Subject: [GIT PULL 07/10] pmu-exynos for v3.10
Message-ID: <51630A2C.7060409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit da821eb7d42935b0f7056d98c75fd1150f6636f4:

   Merge commit 'v3.9-rc5' into next/clk-exynos (2013-04-09 01:10:13 +0900)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/pmu-exynos-for-v3.10

for you to fetch changes up to db35234ec7a7a10145cf472f68e1c73fbd48f79c:

   ARM: EXYNOS: Add arm-pmu DT binding for exynos421x (2013-04-09 
01:49:16 +0900)

----------------------------------------------------------------
add support arm-pmu for exynos4 and exynos5250

----------------------------------------------------------------
Chanho Park (5):
       irqchip: exynos-combiner: Add set_irq_affinity function for 
combiner_irq
       irqchip: exynos-combiner: Correct combined IRQs for exynos4
       ARM: EXYNOS: Enable PMUs for exynos4
       ARM: EXYNOS: Add arm-pmu DT binding for exynos5250
       ARM: EXYNOS: Add arm-pmu DT binding for exynos421x

  arch/arm/boot/dts/exynos4210.dtsi        |  6 +++
  arch/arm/boot/dts/exynos5250.dtsi        |  6 +++
  arch/arm/mach-exynos/common.c            | 28 +++++++++++
  arch/arm/mach-exynos/include/mach/irqs.h | 13 ++++--
  arch/arm/plat-samsung/devs.c             |  2 +-
  drivers/irqchip/exynos-combiner.c        | 80 
+++++++++++++++++++++++++-------
  6 files changed, 113 insertions(+), 22 deletions(-)

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
