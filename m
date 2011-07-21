From: jhbird.choi@samsung.com (jhbird.choi at samsung.com)
Date: Thu, 21 Jul 2011 15:21:37 +0900
Subject: [PATCH] ARM: EXYNOS4: Add missing S3C_VA_UARTx
Message-ID: <1311229297-4423-1-git-send-email-jhbird.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Fix compile error with CONFIG_SAMSUNG_PM_DEBUG

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/map.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 0009e77..5ddbfe3 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -151,6 +151,7 @@
 #define SAMSUNG_PA_KEYPAD		EXYNOS4_PA_KEYPAD
 
 /* UART */
+#define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 
 #define S3C_PA_UART			EXYNOS4_PA_UART
 
-- 
1.7.0
