From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  8 Aug 2012 00:07:55 -0300
Subject: [PATCH] ARM: mxs_defconfig: Add framebuffer support
Message-ID: <1344395275-6275-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add framebuffer support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

I did not test it as I do not have an LCD for mx28evk handy.

 arch/arm/configs/mxs_defconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 4cb6170..6166838 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -110,6 +110,12 @@ CONFIG_SND_SOC_I2C_AND_SPI=y
 CONFIG_SND_SOC_SGTL5000=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_FB=y
+CONFIG_FB_MXS=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FONTS=y
+CONFIG_LOGO=y
 CONFIG_USB=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
-- 
1.7.1
