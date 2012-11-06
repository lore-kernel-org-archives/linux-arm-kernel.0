From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 06 Nov 2012 11:46:58 +0530
Subject: [PATCH] ARM: EXYNOS5: Fix system register base address
Message-ID: <1352182618-29134-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix incorrect PA of the system register on exynos5.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/include/mach/map.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index ef4958b..6ef983c 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -55,7 +55,7 @@
 #define EXYNOS_PA_CHIPID		0x10000000
 
 #define EXYNOS4_PA_SYSCON		0x10010000
-#define EXYNOS5_PA_SYSCON		0x10050100
+#define EXYNOS5_PA_SYSCON		0x10050000
 
 #define EXYNOS4_PA_PMU			0x10020000
 #define EXYNOS5_PA_PMU			0x10040000
-- 
1.6.6.1
