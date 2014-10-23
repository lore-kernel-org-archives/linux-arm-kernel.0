From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Oct 2014 16:18:42 +0100
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Enable support for ST's LPC
 Watchdog
In-Reply-To: <1414077524-6469-1-git-send-email-lee.jones@linaro.org>
References: <1414077524-6469-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1414077524-6469-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 99a8a4a..e34d5c6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -238,6 +238,7 @@ CONFIG_ST_THERMAL_SYSCFG=y
 CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_ST_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_BCM590XX=y
-- 
1.9.1
