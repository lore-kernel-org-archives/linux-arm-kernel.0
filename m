From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Dec 2014 11:25:32 +0000
Subject: [PATCH 2/8] ARM: multi_v7_defconfig: Enable support for ST's LPC RTC
In-Reply-To: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
References: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1418642738-17407-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e34d5c6..09b8bce 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -344,6 +344,7 @@ CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_PALMAS=y
+CONFIG_RTC_DRV_ST_LPC=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
-- 
1.9.1
