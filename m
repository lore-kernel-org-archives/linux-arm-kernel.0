From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:24 +0100
Subject: [RESEND 02/10] ARM: multi_v7_defconfig: Enable ST's Power Reset driver
In-Reply-To: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436173112-21397-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 21c9e12..4144fa4 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -355,6 +355,7 @@ CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_POWER_RESET_SUN6I=y
 CONFIG_POWER_RESET_RMOBILE=y
+CONFIG_POWER_RESET_ST=m
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_THERMAL=y
-- 
1.9.1
