From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat, 30 May 2015 15:58:35 +0900
Subject: [PATCH] ARM: EXYNOS: pmu: Make local function static
Message-ID: <1432969115-19305-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function is not used outside of this unit, make it static.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/mach-exynos/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index e812c1c85624..8d5b0dcc618b 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -698,7 +698,7 @@ static void exynos_power_off(void)
 		;
 }
 
-void exynos5420_powerdown_conf(enum sys_powerdown mode)
+static void exynos5420_powerdown_conf(enum sys_powerdown mode)
 {
 	u32 this_cluster;
 
-- 
2.1.4
