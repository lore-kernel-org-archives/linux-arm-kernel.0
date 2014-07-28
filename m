From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 28 Jul 2014 17:45:26 +0530
Subject: [PATCH 2/2] ARM: EXYNOS: Add exynos5260 PMU compatible string to DT
 match table
In-Reply-To: <1406549726-10452-1-git-send-email-vikas.sajjan@samsung.com>
References: <1406549726-10452-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1406549726-10452-3-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos initialisation code now relies on obtaining the PMU address via
DT node, so add the exynos5260 PMU compatible string to DT match table.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index df41bd1..e4f7270 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -253,6 +253,7 @@ static const struct of_device_id exynos_dt_pmu_match[] = {
 	{ .compatible = "samsung,exynos4412-pmu" },
 	{ .compatible = "samsung,exynos5250-pmu" },
 	{ .compatible = "samsung,exynos5420-pmu" },
+	{ .compatible = "samsung,exynos5260-pmu" },
 	{ /*sentinel*/ },
 };
 
-- 
1.7.9.5
