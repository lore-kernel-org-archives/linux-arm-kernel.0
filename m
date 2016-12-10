From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 Dec 2016 18:38:38 +0530
Subject: [PATCH v8 3/8] ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
In-Reply-To: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
References: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1481375323-29724-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables exynos_chipid driver for ARCH_EXYNOS
based SoC.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 72f4eac..e6aa5c2 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -53,6 +53,7 @@ config ARCH_BRCMSTB
 
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
+	select EXYNOS_CHIPID
 	select COMMON_CLK_SAMSUNG
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
-- 
2.7.4
