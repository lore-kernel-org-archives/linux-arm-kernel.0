From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Oct 2014 14:22:07 +0200
Subject: [PATCH 6/7] ARM: exynos_defconfig: Enable Maxim 77693 charger
In-Reply-To: <1412252528-30148-1-git-send-email-k.kozlowski@samsung.com>
References: <1412252528-30148-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1412252528-30148-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the max77693 charger driver used on Trats2 board. This allows
querying the charging status through power supply interface.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index b14d8c3f7e12..78a963de612a 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -79,6 +79,7 @@ CONFIG_DEBUG_GPIO=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
+CONFIG_CHARGER_MAX77693=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
-- 
1.9.1
