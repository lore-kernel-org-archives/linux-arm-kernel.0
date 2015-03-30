From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 30 Mar 2015 16:40:16 +0200
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Add gpio-restart driver
In-Reply-To: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1427726418-3806-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7ffa4aa..17e89b0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -314,6 +314,7 @@ CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
+CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_POWER_RESET_SUN6I=y
 CONFIG_POWER_RESET_RMOBILE=y
-- 
2.1.0
