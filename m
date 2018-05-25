From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 25 May 2018 21:24:38 +0200
Subject: [PATCH V3 5/6] ARM: multi_v7_defconfig: Enable RPi voltage sensor
In-Reply-To: <1527276279-23876-1-git-send-email-stefan.wahren@i2se.com>
References: <1527276279-23876-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1527276279-23876-6-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch enables the hwmon driver for the Raspberry Pi.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7b2283a..2af46fd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -449,6 +449,7 @@ CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_SENSORS_NTC_THERMISTOR=m
 CONFIG_SENSORS_PWM_FAN=m
+CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
-- 
2.7.4
