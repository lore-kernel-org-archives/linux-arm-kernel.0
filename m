From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 03 Apr 2014 15:30:22 +0530
Subject: [PATCH v7 1/3] ARM: EXYNOS: initial board support for exynos5260 SoC
In-Reply-To: <1396519224-18712-1-git-send-email-rahul.sharma@samsung.com>
References: <1396519224-18712-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1396519224-18712-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch add basic arch side support for exynos5260 SoC.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/Kconfig  |    5 +++++
 arch/arm/mach-exynos/exynos.c |    1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 5c34dc2..6c48844 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -51,6 +51,11 @@ config SOC_EXYNOS5250
 	default y
 	depends on ARCH_EXYNOS5
 
+config SOC_EXYNOS5260
+	bool "SAMSUNG EXYNOS5260"
+	default y
+	depends on ARCH_EXYNOS5
+
 config SOC_EXYNOS5420
 	bool "SAMSUNG EXYNOS5420"
 	default y
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index b567361..5324051 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -374,6 +374,7 @@ static char const *exynos_dt_compat[] __initconst = {
 	"samsung,exynos4412",
 	"samsung,exynos5",
 	"samsung,exynos5250",
+	"samsung,exynos5260",
 	"samsung,exynos5420",
 	"samsung,exynos5440",
 	NULL
-- 
1.7.9.5
