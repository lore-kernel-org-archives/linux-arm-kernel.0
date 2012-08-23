From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 23 Aug 2012 16:54:58 +0530
Subject: [PATCH v2 2/2] ARM: EXYNOS: Enable pinctrl driver support for Exynos4
 device tree enabled platform
In-Reply-To: <1345721098-32459-1-git-send-email-thomas.abraham@linaro.org>
References: <1345721098-32459-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1345721098-32459-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables support for Samsung and Exynos4 pinctrl driver for device
tree enabled Exynos4 platforms.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b5b4c8c..195b50e 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -405,6 +405,8 @@ config MACH_EXYNOS4_DT
 	select USE_OF
 	select ARM_AMBA
 	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
+	select PINCTRL
+	select PINCTRL_EXYNOS4
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the Exynos4 SoC based board.
-- 
1.6.6.rc2
