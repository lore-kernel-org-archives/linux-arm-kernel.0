From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 17:02:12 +0100
Subject: [PATCH 06/20] ARM: ux500: CONFIG: Enable ST's IIO Sensors by default
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379347346-823-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These include; Pressure, Accelerometer, Magnetometer and Gyroscope Sensors

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index a0025dc..aaa6c0a 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -37,6 +37,11 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_SENSORS_BH1780=y
+CONFIG_IIO=y
+CONFIG_IIO_ST_PRESS=y
+CONFIG_IIO_ST_ACCEL_3AXIS=y
+CONFIG_IIO_ST_MAGN_3AXIS=y
+CONFIG_IIO_ST_GYRO_3AXIS=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
-- 
1.8.1.2
