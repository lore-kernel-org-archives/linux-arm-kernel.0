From: manabian@gmail.com (Joachim Eastwood)
Date: Sun,  8 May 2016 13:55:39 +0200
Subject: [PATCH] ARM: configs: lpc18xx: enable adc and dac iio drivers
Message-ID: <1462708539-9222-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ADC and DAC IIO drivers for LPC18xx/43xx SoCs.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi arm-soc team,

Only one simple defconfig update for lpc18xx this cycle. So please
apply this one directly. Thanks!


regards,
Joachim Eastwood

 arch/arm/configs/lpc18xx_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 2ae00b0..2de1bf0 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -149,6 +149,8 @@ CONFIG_PWM=y
 CONFIG_PWM_LPC18XX_SCT=y
 CONFIG_IIO=y
 CONFIG_MMA7455_I2C=y
+CONFIG_LPC18XX_ADC=y
+CONFIG_LPC18XX_DAC=y
 CONFIG_IIO_SYSFS_TRIGGER=y
 CONFIG_PHY_LPC18XX_USB_OTG=y
 CONFIG_NVMEM=y
-- 
2.8.2
