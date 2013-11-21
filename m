From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 21 Nov 2013 13:06:06 +0100
Subject: [PATCH] ARM: exynos_defconfig: increase CONFIG_NR_CPUS value to 8
Message-ID: <1511364.Pd4tSi34z7@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current CONFIG_NR_CPUS value (2) is too small for:
- EXYNOS4412 (4 cores)
- EXYNOS5440 (4 cores)
- EXYNOS5410 (8 cores)
- EXYNOS5420 (8 cores)

Set CONFIG_NR_CPUS to 8 so it is correct for all currently
supported SoCs.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index ad7dfbb..aec8a3e 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -13,7 +13,7 @@ CONFIG_S3C24XX_PWM=y
 CONFIG_ARCH_EXYNOS5=y
 CONFIG_MACH_EXYNOS4_DT=y
 CONFIG_SMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=8
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-- 
1.8.2.3
