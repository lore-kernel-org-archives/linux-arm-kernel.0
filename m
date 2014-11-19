From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 19 Nov 2014 16:56:23 +0100
Subject: [PATCH 3/4] ARM: exynos_defconfig: Enable LM90 driver
In-Reply-To: <1416412585-10809-1-git-send-email-afaerber@suse.de>
References: <1416412585-10809-1-git-send-email-afaerber@suse.de>
Message-ID: <1416412585-10809-4-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

multi_v7_defconfig has it as Y already, so build it in here, too, for
consistency, and therefore build in HWMON as well.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/configs/exynos_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 8dfa7d312f51..2d7d2027aeb9 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -84,7 +84,8 @@ CONFIG_DEBUG_GPIO=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
-# CONFIG_HWMON is not set
+CONFIG_HWMON=y
+CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_EXYNOS_THERMAL_CORE=y
-- 
2.1.2
