From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 16 Aug 2012 01:40:42 +0530
Subject: [PATCH 2/2] ARM: EXYNOS: Enable PINCTRL config option for Exynos4
 device tree enabled platform
In-Reply-To: <1345061442-32378-1-git-send-email-thomas.abraham@linaro.org>
References: <1345061442-32378-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1345061442-32378-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables support for Samsung and Exynos4 pinctrl driver for device
tree enabled Exynos4 platforms.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b5b4c8c..ad96c59 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -405,6 +405,7 @@ config MACH_EXYNOS4_DT
 	select USE_OF
 	select ARM_AMBA
 	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
+	select PINCTRL
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the Exynos4 SoC based board.
-- 
1.6.6.rc2
