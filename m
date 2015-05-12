From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 May 2015 13:51:45 +0100
Subject: [PATCH 08/13] ARM: multi_v7_defconfig: Enable ST's Power Reset driver
In-Reply-To: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
References: <1431435110-22595-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431435110-22595-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5dc85db..f632af0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -321,6 +321,7 @@ CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_POWER_RESET_SUN6I=y
 CONFIG_POWER_RESET_RMOBILE=y
+CONFIG_POWER_RESET_ST=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_THERMAL=y
-- 
1.9.1
