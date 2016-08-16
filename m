From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Aug 2016 15:27:19 +0900
Subject: [PATCH 3/7] cpufreq: dt: Add exynos5433 compatible to use generic
 cpufreq driver
In-Reply-To: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471328843-26653-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the exynos5433 compatible string for supporting
the generic cpufreq driver on Exynos5433.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm at vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 0bb44d5b5df4..470db30f745f 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -40,6 +40,7 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "samsung,exynos5250", },
 #ifndef CONFIG_BL_SWITCHER
 	{ .compatible = "samsung,exynos5420", },
+	{ .compatible = "samsung,exynos5433", },
 	{ .compatible = "samsung,exynos5800", },
 #endif
 
-- 
1.9.1
