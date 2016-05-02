From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  2 May 2016 10:43:18 +0200
Subject: [PATCH 1/2] ARM: u8500_defconfig: remove staging from defconfig
Message-ID: <1462178598-13651-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ux500 was enabling the staging drivers due to the RMI4
touchscreen driver, this is now properly upstream, so drop
this and the dead symbol for the old RMI4 hack from
the defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index d2a3a67f198a..0ce2aa73c28a 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -107,8 +107,6 @@ CONFIG_RTC_DRV_AB8500=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
 CONFIG_STE_DMA40=y
-CONFIG_STAGING=y
-CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4=y
 CONFIG_HSEM_U8500=y
 CONFIG_IIO=y
 CONFIG_IIO_ST_ACCEL_3AXIS=y
-- 
2.4.11
