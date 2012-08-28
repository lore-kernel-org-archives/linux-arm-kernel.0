From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 28 Aug 2012 12:01:05 +0200
Subject: [PATCH 0/3] ARM: EXYNOS: Add support for GPIO on Exynos4x12
Message-ID: <4648723.rWnut7F0uJ@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series makes necessary preparations and adds support for GPIO on 
Exynos4x12 SoCs.

Tomasz Figa (3):
  ARM: EXYNOS: Use EXYNOS4210_GPEx instead of EXYNOS4_GPEx
  gpio: samsung: Add support for Exynos4x12 SoCs
  ARM: EXYNOS: Add support for FIMC cam port B GPIO setup on Exynos4x12

 arch/arm/mach-exynos/include/mach/gpio.h   |   58 ++++--
 arch/arm/mach-exynos/include/mach/irqs.h   |    6 -
 arch/arm/mach-exynos/mach-nuri.c           |   16 +-
 arch/arm/mach-exynos/mach-origen.c         |    6 +-
 arch/arm/mach-exynos/mach-trats.c          |    4 +-
 arch/arm/mach-exynos/mach-universal_c210.c |   32 ++--
 arch/arm/mach-exynos/setup-fimc.c          |   21 ++-
 drivers/gpio/gpio-samsung.c                |  351 
++++++++++++++++++++++++----
 8 files changed, 399 insertions(+), 95 deletions(-)

-- 
1.7.8.6
