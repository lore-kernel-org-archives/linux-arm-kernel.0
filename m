From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 25 May 2018 21:24:39 +0200
Subject: [PATCH V3 6/6] arm64: defconfig: Enable RPi voltage sensor
In-Reply-To: <1527276279-23876-1-git-send-email-stefan.wahren@i2se.com>
References: <1527276279-23876-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1527276279-23876-7-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch enables the hwmon driver for the Raspberry Pi.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3299505..e5c7198 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -353,6 +353,7 @@ CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_INA2XX=m
+CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
-- 
2.7.4
