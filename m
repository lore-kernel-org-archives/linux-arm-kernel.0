From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Thu, 9 Jul 2015 01:23:00 +0800
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: enable powerkey and syscon
 power off
In-Reply-To: <1436376180-5891-1-git-send-email-Frank.Li@freescale.com>
References: <1436376180-5891-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1436376180-5891-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

build in snvs powerkey
build in syscon power off support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4458554..5303eda 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -151,6 +151,7 @@ CONFIG_WLCORE_SDIO=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=m
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_SNVS_PWRKEY=y
 CONFIG_KEYBOARD_IMX=y
 CONFIG_MOUSE_PS2=m
 CONFIG_MOUSE_PS2_ELANTECH=y
@@ -186,6 +187,7 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_IMX=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
-- 
1.9.1
