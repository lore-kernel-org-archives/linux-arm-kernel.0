From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 16 Apr 2014 09:28:56 +0530
Subject: [PATCH v8 1/3] ARM: EXYNOS: initial board support for exynos5260 SoC
In-Reply-To: <1397620738-14431-1-git-send-email-rahul.sharma@samsung.com>
References: <1397620738-14431-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1397620738-14431-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch add basic arch side support for exynos5260 SoC.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index fc8bf18..bf4ed87 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -84,6 +84,11 @@ config SOC_EXYNOS5250
 	help
 	  Enable EXYNOS5250 SoC support
 
+config SOC_EXYNOS5260
+	bool "SAMSUNG EXYNOS5260"
+	default y
+	depends on ARCH_EXYNOS5
+
 config SOC_EXYNOS5420
 	bool "SAMSUNG EXYNOS5420"
 	default y
-- 
1.7.9.5
