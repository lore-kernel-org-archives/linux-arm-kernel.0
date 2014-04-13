From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 13 Apr 2014 21:11:24 +0200
Subject: [PATCH] ARM: ux500: configure in sensors
Message-ID: <1397416284-4588-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the STMicroelectronics MEMS sensors for accelerometer,
gyroscope, magnetometer and pressure that are mounted on the Ux500
models.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index dac0a876e737..726b1fa786f7 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -103,6 +103,11 @@ CONFIG_STE_DMA40=y
 CONFIG_STAGING=y
 CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4=y
 CONFIG_HSEM_U8500=y
+CONFIG_IIO=y
+CONFIG_IIO_ST_ACCEL_3AXIS=y
+CONFIG_IIO_ST_GYRO_3AXIS=y
+CONFIG_IIO_ST_MAGN_3AXIS=y
+CONFIG_IIO_ST_PRESS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.9.0
