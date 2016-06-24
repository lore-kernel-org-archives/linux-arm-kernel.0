From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 24 Jun 2016 15:25:25 +0800
Subject: [PATCH] ARM: at91/defconfig: Add ACT8945A driver
Message-ID: <1466753125-4168-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include ACT8945A mfd, regulator and power drivers.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/configs/sama5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 9cb1a85..aca8625 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -129,16 +129,19 @@ CONFIG_SPI_ATMEL=y
 CONFIG_SPI_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_BATTERY_ACT8945A=y
 CONFIG_POWER_RESET=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SAMA5D4_WATCHDOG=y
+CONFIG_MFD_ACT8945A=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
 CONFIG_MFD_ATMEL_HLCDC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ACT8865=y
+CONFIG_REGULATOR_ACT8945A=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
-- 
2.7.4
