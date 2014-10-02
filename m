From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Oct 2014 14:22:08 +0200
Subject: [PATCH 7/7] ARM: multi_v7_defconfig: Enable Maxim 77693 charger
In-Reply-To: <1412252528-30148-1-git-send-email-k.kozlowski@samsung.com>
References: <1412252528-30148-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1412252528-30148-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the max77693 charger driver used on Trats2 board. This allows
querying the charging status through power supply interface.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a25549d015e8..54367775aade 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -248,6 +248,7 @@ CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
+CONFIG_CHARGER_MAX77693=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_SUN6I=y
-- 
1.9.1
