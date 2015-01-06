From: moon.linux@yahoo.com (Anand Moon)
Date: Tue,  6 Jan 2015 23:12:31 +0530
Subject: [PATCH] ARM: exynos_defconfig: Enable CONFIG_LOCKUP_DETECTOR
Message-ID: <1420566151-7136-1-git-send-email-moon.linux@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM Enable CONFIG_LOCKUP_DETECTOR to validaion of kernel locks

Tested on Exynos5422 ODROID XU3 board.

Signed-off-by: Anand Moon <moon.linux@yahoo.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 5ef14de..ecd9987 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -178,6 +178,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_LOCKUP_DETECTOR=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
-- 
2.1.0
