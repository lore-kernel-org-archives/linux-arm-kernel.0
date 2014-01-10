From: denis@eukrea.com (Denis Carikli)
Date: Fri, 10 Jan 2014 16:07:24 +0100
Subject: [PATCHv9 2/2] ARM: imx_v6_v7_defconfig: Enable backlight gpio support.
In-Reply-To: <1389366444-29449-1-git-send-email-denis@eukrea.com>
References: <1389366444-29449-1-git-send-email-denis@eukrea.com>
Message-ID: <1389366444-29449-2-git-send-email-denis@eukrea.com>
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
Changelog:
- This patch has been splitted out of my imx-drm v5 patchset:
  http://lists.freedesktop.org/archives/dri-devel/2013-December/050124.html
  which will be resubmitted later without that patch.

- This patch is unchanged since the imx-drm v5 patchset,
  where it was first introduced.
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 00746d5..f2b2911 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -188,6 +188,7 @@ CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
+CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
-- 
1.7.9.5
