From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:44:24 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add BQ24735, ANATOP and PWM_IMX
Message-ID: <1438872264-24953-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Found the need for these when testing multiv7 kernels on a bunch of
boards.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4c5431e99522..827b91d887aa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -349,6 +349,7 @@ CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_BATTERY_SBS=y
+CONFIG_CHARGER_BQ24735=y
 CONFIG_BATTERY_MAX17040=m
 CONFIG_BATTERY_MAX17042=m
 CONFIG_CHARGER_MAX14577=m
@@ -396,6 +397,7 @@ CONFIG_MFD_TPS65090=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_AB8500=y
+CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_AXP20X=y
@@ -631,6 +633,7 @@ CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_TCB=m
+CONFIG_PWM_IMX=y
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SUN4I=y
-- 
2.4.3
