From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 21 Jul 2011 19:26:04 +0900
Subject: [PATCH] ARM: EXYNOS4: Update config file of NURI to enable RTC
Message-ID: <4E27FEBC.7050302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update config file of NURI board to enable RTC

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index b735705..bb675fb 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -184,6 +184,7 @@ config MACH_NURI
 	bool "Mobile NURI Board"
 	select CPU_EXYNOS4210
 	select S3C_DEV_WDT
+	select S3C_DEV_RTC
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
-- 
1.7.0.4
