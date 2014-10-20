From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 20 Oct 2014 21:08:41 +0900
Subject: [PATCHv4 3/4] ARM: exynos: Add exynos3250 compatible to use generic
 cpufreq driver
In-Reply-To: <1413806922-22722-1-git-send-email-cw00.choi@samsung.com>
References: <1413806922-22722-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1413806922-22722-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add exynos3250 compatible string to exynos_cpufreq_matches
for supporting generic cpufreq driver on Exynos3250.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a1be294..c835a389 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -286,6 +286,7 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos5440", .data = "exynos5440-cpufreq" },
 	{ /* sentinel */ }
 };
-- 
1.8.0
