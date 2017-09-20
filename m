From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 20 Sep 2017 10:56:10 -0300
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Select the CEC driver
In-Reply-To: <1505915770-17136-1-git-send-email-fabio.estevam@nxp.com>
References: <1505915770-17136-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1505915770-17136-3-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_DRM_DW_HDMI_CEC option, so that the CEC driver can be
loaded by default.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 32acac9..1e698fa 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -250,6 +250,7 @@ CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
+CONFIG_DRM_DW_HDMI_CEC=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_TVE=y
-- 
2.7.4
