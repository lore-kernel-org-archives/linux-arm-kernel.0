From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 19 Mar 2014 17:55:56 +0530
Subject: [PATCH 3/4] ARM: EXYNOS: Add generic compatible strings
In-Reply-To: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
References: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1395231957-22032-4-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add generic compatible strings for Exynos4 and 5 platforms so that
future SoCs can use them if there is nothing extra/specific to be
differentiated.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-exynos/exynos.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index b6fd40e76936..07884efd3a48 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -343,9 +343,11 @@ static void __init exynos_dt_machine_init(void)
 }
 
 static char const *exynos_dt_compat[] __initconst = {
+	"samsung,exynos4",
 	"samsung,exynos4210",
 	"samsung,exynos4212",
 	"samsung,exynos4412",
+	"samsung,exynos5",
 	"samsung,exynos5250",
 	"samsung,exynos5420",
 	"samsung,exynos5440",
-- 
1.7.9.5
