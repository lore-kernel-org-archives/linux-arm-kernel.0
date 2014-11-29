From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Sat, 29 Nov 2014 19:45:08 +0530
Subject: [PATCH v5 6/6] arm: exynos: Select SOC_SAMSUNG config option
In-Reply-To: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
References: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1417270508-11174-7-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config option SOC_SAMSUNG is needed to enable all soc samsung
drivers inside driver/soc/samsung folder. Currently, this will be useful to
enable exynos pmu driver which is moved to that folder.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b9e3f1c..17880b6 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -25,6 +25,7 @@ menuconfig ARCH_EXYNOS
 	select S5P_DEV_MFC
 	select SRAM
 	select MFD_SYSCON
+	select SOC_SAMSUNG
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
-- 
1.7.9.5
