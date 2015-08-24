From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 24 Aug 2015 13:32:23 +0530
Subject: [PATCH v2 2/7] ARM: EXYNOS: code cleanup in map.h
In-Reply-To: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
References: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1440403348-8974-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused exynos5440 uart offset macro.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/include/mach/map.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index a2acba3..86d8085 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -35,8 +35,4 @@
 #define EXYNOS4_PA_SROMC		0x12570000
 #define EXYNOS5_PA_SROMC		0x12250000
 
-/* Compatibility UART */
-
-#define EXYNOS5440_PA_UART0		0x000B0000
-
 #endif /* __ASM_ARCH_MAP_H */
-- 
2.4.5
