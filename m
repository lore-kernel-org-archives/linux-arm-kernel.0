From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Wed, 09 Jul 2014 16:55:46 +0530
Subject: [PATCH 2/3] arm: exynos: Add exynos5800-pmu compatible entry
In-Reply-To: <1404905147-30319-1-git-send-email-vikas.sajjan@samsung.com>
References: <1404905147-30319-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1404905147-30319-3-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds exynos5800-pmu compatible string entry in the pmu table.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index d75d3e8..d5853b1 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -253,6 +253,7 @@ static const struct of_device_id exynos_dt_pmu_match[] = {
 	{ .compatible = "samsung,exynos4412-pmu" },
 	{ .compatible = "samsung,exynos5250-pmu" },
 	{ .compatible = "samsung,exynos5420-pmu" },
+	{ .compatible = "samsung,exynos5800-pmu" },
 	{ /*sentinel*/ },
 };
 
-- 
1.7.9.5
