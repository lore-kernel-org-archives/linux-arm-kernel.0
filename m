From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 12 Dec 2015 13:13:56 +0530
Subject: [RESEND PATCH v5 2/8] ARM: EXYNOS: code cleanup in map.h
In-Reply-To: <1449906242-20843-1-git-send-email-pankaj.dubey@samsung.com>
References: <1449906242-20843-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1449906242-20843-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused exynos5440 uart offset macro.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kukjin Kim <kgene@kernel.org>
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
1.9.1
