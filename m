From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Thu, 21 Aug 2014 18:52:36 +0545
Subject: [PATCH v2 2/3] ARM: exynos: Add exynos5800-pmu compatible entry
In-Reply-To: <1408626457-3422-1-git-send-email-vikas.sajjan@samsung.com>
References: <1408626457-3422-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <1408626457-3422-3-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds exynos5800-pmu compatible string entry in the pmu table.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 6a24e11..90377c9 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -255,6 +255,7 @@ static const struct of_device_id exynos_dt_pmu_match[] = {
 	{ .compatible = "samsung,exynos5260-pmu" },
 	{ .compatible = "samsung,exynos5410-pmu" },
 	{ .compatible = "samsung,exynos5420-pmu" },
+	{ .compatible = "samsung,exynos5800-pmu" },
 	{ /*sentinel*/ },
 };
 
-- 
1.7.9.5
