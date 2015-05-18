From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 May 2015 09:44:32 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Remove unused Kconfig option
 MACH_UX500_DT
Message-ID: <1431938672-11142-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 06075b6..54b2936 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -84,7 +84,6 @@ CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
-CONFIG_MACH_UX500_DT=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VEXPRESS_CA9X4=y
 CONFIG_ARCH_WM8850=y
-- 
1.9.1
