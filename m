From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 25 Feb 2018 16:38:09 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3
Message-ID: <1519573089-27976-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This turns on the CONFIG_BCM2835_THERMAL as module for
Raspberry Pi 2 and 3.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f77bd01..a431989 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -465,6 +465,7 @@ CONFIG_SENSORS_NTC_THERMISTOR=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
+CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
2.7.4
