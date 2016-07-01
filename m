From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  1 Jul 2016 22:26:30 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: add ACT8945A
Message-ID: <1467404790-21980-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACT8945A is the PMIC present on the sama5d2 Xplained.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f857564657f..94c22b05e744 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -403,6 +403,7 @@ CONFIG_GPIO_PALMAS=y
 CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
+CONFIG_BATTERY_ACT8945A=y
 CONFIG_BATTERY_SBS=y
 CONFIG_BATTERY_MAX17040=m
 CONFIG_BATTERY_MAX17042=m
@@ -448,6 +449,7 @@ CONFIG_MESON_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_DIGICOLOR_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_ACT8945A=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
@@ -477,6 +479,7 @@ CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
+CONFIG_REGULATOR_ACT8945A=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_ACT8865=y
 CONFIG_REGULATOR_AS3711=y
-- 
2.8.1
