From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 16 May 2018 15:37:05 +0200
Subject: [PATCH RFC 4/6] ARM: bcm2835_defconfig: Enable RPi voltage sensor
In-Reply-To: <1526477827-10859-1-git-send-email-stefan.wahren@i2se.com>
References: <1526477827-10859-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1526477827-10859-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch enables the hwmon driver for the Raspberry Pi.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/configs/bcm2835_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index e4d188f..e9bc889 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -86,7 +86,7 @@ CONFIG_SPI=y
 CONFIG_SPI_BCM2835=y
 CONFIG_SPI_BCM2835AUX=y
 CONFIG_GPIO_SYSFS=y
-# CONFIG_HWMON is not set
+CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_THERMAL=y
 CONFIG_BCM2835_THERMAL=y
 CONFIG_WATCHDOG=y
-- 
2.7.4
