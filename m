From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:47:00 +0530
Subject: [PATCH v9 06/12] ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131431epcas5p447a730e1bb194162f262a819ae665efb@epcas5p4.samsung.com>
Message-ID: <1490879826-16754-7-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables exynos_chipid driver for ARCH_EXYNOS
based SoC.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 9cdaecd..b238204 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -54,6 +54,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
2.7.4
