From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 13:22:52 +0930
Subject: [PATCHv2 1/3] ARM: exynos_defconfig: Enable CONFIG_SENSORS_PWM_FAN
 for odroidxu3 pmw-fan
In-Reply-To: <1431489174-4479-1-git-send-email-linux.amoon@gmail.com>
References: <1431489174-4479-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1431489174-4479-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_SENSORS_PWM_FAN on exynos_defconfig to control fan power on Odroidxu3.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d034c96..3c2784f 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -101,6 +101,7 @@ CONFIG_CHARGER_MAX77693=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_HWMON=y
 CONFIG_SENSORS_LM90=y
+CONFIG_SENSORS_PWM_FAN=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL=y
-- 
1.9.1
