From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 17:39:20 -0300
Subject: [PATCH 5/6] ARM: mxs_defconfig: Select CONFIG_DRM_PANEL_SEIKO_43WVF1G
In-Reply-To: <1532119161-16597-1-git-send-email-festevam@gmail.com>
References: <1532119161-16597-1-git-send-email-festevam@gmail.com>
Message-ID: <1532119161-16597-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx23-evk and imx28-evk boards use a Seiko 43WVF1G panel.

Now that the DRM mxsfb driver is the one selected by default, let's
also select CONFIG_DRM_PANEL_SEIKO_43WVF1G so that these boards continue
to have a working display by default.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/mxs_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 148226e..7b82128 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -95,6 +95,7 @@ CONFIG_MFD_MXS_LRADC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_DRM=y
+CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
 CONFIG_DRM_MXSFB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
2.7.4
