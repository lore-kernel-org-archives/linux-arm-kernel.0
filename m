From: ijc@hellion.org.uk (Ian Campbell)
Date: Sun, 14 Sep 2014 20:24:10 +0100
Subject: [PATCH] trivial: Fix typo "Crotex" in CONFIG_ARCH_EXYNOS3 help
Message-ID: <1410722650-6428-1-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: trivial at kernel.org
---
 arch/arm/mach-exynos/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 8f9b66c..e201e0b 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -33,7 +33,7 @@ config ARCH_EXYNOS3
 	bool "SAMSUNG EXYNOS3"
 	select ARM_CPU_SUSPEND if PM
 	help
-	  Samsung EXYNOS3 (Crotex-A7) SoC based systems
+	  Samsung EXYNOS3 (Cortex-A7) SoC based systems
 
 config ARCH_EXYNOS4
 	bool "SAMSUNG EXYNOS4"
-- 
1.7.10.4
