From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed,  8 Jun 2016 11:22:03 -0600
Subject: [PATCH] ARM: exynos_defconfig add CONFIG_EXYNOS_IOMMU in not set mode
Message-ID: <1465406523-7075-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CONFIG_EXYNOS_IOMMU in not set mode to make it easier to enable it.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index daf9762..16c2957 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -218,6 +218,7 @@ CONFIG_CROS_EC_CHARDEV=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=y
 CONFIG_COMMON_CLK_S2MPS11=y
+# CONFIG_EXYNOS_IOMMU is not set
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14577=y
 CONFIG_EXTCON_MAX77693=y
-- 
2.7.4
