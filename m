From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Dec 2015 15:58:09 +0000
Subject: [PATCH v6 02/10] ARM: multi_v7_defconfig: Enable ST's Power Reset
 driver
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449676697-25432-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 99b87b6..f62dcb1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -371,6 +371,7 @@ CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_POWER_RESET_RMOBILE=y
+CONFIG_POWER_RESET_ST=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_SENSORS_NTC_THERMISTOR=m
-- 
1.9.1
