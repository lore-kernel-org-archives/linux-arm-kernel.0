From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 27 Sep 2012 15:52:33 +0530
Subject: [PATCH V2] ARM: EXYNOS5: Add I2S SFR base addresses
Message-ID: <1348741353-29297-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2S controller0,1,2 base addresses

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-exynos/include/mach/map.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 5aa77f9..792c0bd 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -42,6 +42,9 @@
 #define EXYNOS4_PA_I2S0			0x03830000
 #define EXYNOS4_PA_I2S1			0xE3100000
 #define EXYNOS4_PA_I2S2			0xE2A00000
+#define EXYNOS5_PA_I2S0			0x03830000
+#define EXYNOS5_PA_I2S1			0x12D60000
+#define EXYNOS5_PA_I2S2			0x12D70000
 
 #define EXYNOS4_PA_PCM0			0x03840000
 #define EXYNOS4_PA_PCM1			0x13980000
-- 
1.7.4.4
