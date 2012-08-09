From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  9 Aug 2012 18:16:46 -0300
Subject: [PATCH v2] ARM: mxs_defconfig: Add framebuffer support
Message-ID: <1344547006-26738-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add framebuffer support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Add missing features and tested on a mx28evk
 arch/arm/configs/mxs_defconfig |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 9e79125..67d5c05 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -109,6 +109,15 @@ CONFIG_SND_SOC_I2C_AND_SPI=y
 CONFIG_SND_SOC_SGTL5000=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_FB=y
+CONFIG_FB_MXS=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FONTS=y
+CONFIG_LOGO=y
 CONFIG_USB=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
-- 
1.7.1
