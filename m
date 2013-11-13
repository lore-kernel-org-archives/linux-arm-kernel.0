From: denis@eukrea.com (Denis Carikli)
Date: Wed, 13 Nov 2013 10:23:23 +0100
Subject: [PATCHv4][ 7/7] ARM: imx_v6_v7_defconfig: Enable backlight gpio
 support.
In-Reply-To: <1384334603-14208-1-git-send-email-denis@eukrea.com>
References: <1384334603-14208-1-git-send-email-denis@eukrea.com>
Message-ID: <1384334603-14208-7-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eukrea mbimxsd51 has a gpio backlight for its
  LCD display, so we turn that driver on.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index c814e0e..910122c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -178,6 +178,7 @@ CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
+CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
-- 
1.7.9.5
