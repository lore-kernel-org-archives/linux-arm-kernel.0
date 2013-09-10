From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:10 +0100
Subject: [PATCH 09/38] ARM: ux500: CONFIG: Enable ST's IIO Gyroscope Sensors
 by default
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 4b94b42..aaa6c0a 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -41,6 +41,7 @@ CONFIG_IIO=y
 CONFIG_IIO_ST_PRESS=y
 CONFIG_IIO_ST_ACCEL_3AXIS=y
 CONFIG_IIO_ST_MAGN_3AXIS=y
+CONFIG_IIO_ST_GYRO_3AXIS=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
-- 
1.8.1.2
