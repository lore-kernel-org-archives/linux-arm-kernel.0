From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 04 Nov 2016 09:09:24 +0530
Subject: [PATCH 4/4] ARM: EXYNOS: Remove unused soc_is_exynos{4,5}
In-Reply-To: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
References: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1478230764-13748-5-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As no more user of soc_is_exynos{4,5} we can safely remove them.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/common.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9424a8a..d19064b 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -105,11 +105,6 @@ IS_SAMSUNG_CPU(exynos5800, EXYNOS5800_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5800()	0
 #endif
 
-#define soc_is_exynos4() (soc_is_exynos4210() || soc_is_exynos4212() || \
-			  soc_is_exynos4412())
-#define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5410() || \
-			  soc_is_exynos5420() || soc_is_exynos5800())
-
 extern u32 cp15_save_diag;
 extern u32 cp15_save_power;
 
-- 
2.7.4
