From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 17:39:21 -0300
Subject: [PATCH 6/6] ARM: imx_v6_v7_defconfig: Select
 CONFIG_DRM_PANEL_SEIKO_43WVF1G
In-Reply-To: <1532119161-16597-1-git-send-email-festevam@gmail.com>
References: <1532119161-16597-1-git-send-email-festevam@gmail.com>
Message-ID: <1532119161-16597-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6sl-evk, imx6sll-evk and imx6sx-sdb boards use a Seiko 43WVF1G panel.

Now that the DRM mxsfb driver is the one selected by default, let's
also select CONFIG_DRM_PANEL_SEIKO_43WVF1G so that these boards continue
to have a working display by default.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c1276..7eca43f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -257,6 +257,7 @@ CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y
 CONFIG_DRM_IMX=y
-- 
2.7.4
