From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 15 Nov 2018 16:11:32 +0100
Subject: [PATCH 3/9] ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
In-Reply-To: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20181115151221epcas2p17b8bbb240f70fdd7c5ecf1c0c27de35f@epcas2p1.samsung.com>
Message-ID: <1542294698-17470-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

As now we have chipid driver to initialize SoC related information
let's include it in build by default.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b40963c..e3e63aa 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
 	select EXYNOS_SROM
-- 
1.9.1
