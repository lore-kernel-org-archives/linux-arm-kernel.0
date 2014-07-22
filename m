From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 15:52:32 +0100
Subject: [PATCH 5/5] ARM: multi_v7_defconfig: Enable ST's Power Reset driver
In-Reply-To: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
References: <1406040752-25229-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406040752-25229-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5348364..1878e8d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -221,6 +221,7 @@ CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_SUN6I=y
+CONFIG_POWER_RESET_ST=y
 CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
-- 
1.8.3.2
