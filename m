From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 16 Jul 2015 08:39:44 +0200
Subject: [PATCH v2 3/3] ARM: exynos_defconfig: Enable NTC Thermistors support
In-Reply-To: <1437028784-22189-1-git-send-email-javier@osg.samsung.com>
References: <1437028784-22189-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1437028784-22189-4-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5420 Peach Pit and Exynos5800 Peach Pi Chromebooks have
IIO based ADC thermistors. Enable built-in support for its driver.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes in v2:
- Add Krzysztof Kozlowski Reviewed-by tag in patch #3.

 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 9504e7790288..e5d7d4476a80 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -94,6 +94,7 @@ CONFIG_CHARGER_MAX14577=y
 CONFIG_CHARGER_MAX77693=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_SENSORS_LM90=y
+CONFIG_SENSORS_NTC_THERMISTOR=y
 CONFIG_SENSORS_PWM_FAN=y
 CONFIG_SENSORS_INA2XX=y
 CONFIG_THERMAL=y
-- 
2.4.3
