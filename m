From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  6 Nov 2018 10:03:43 -0200
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select the PXP driver
In-Reply-To: <1541505823-14375-1-git-send-email-festevam@gmail.com>
References: <1541505823-14375-1-git-send-email-festevam@gmail.com>
Message-ID: <1541505823-14375-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pixel Pipeline (PXP) block is present on several i.MX SoCs
such as imx6dl, imx6sl, imx6ul, imx6sx, imx6ull and imx7d.

Select the PXP driver by default.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1ad5736..3e2ab0a 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -257,6 +257,7 @@ CONFIG_VIDEO_MUX=y
 CONFIG_SOC_CAMERA=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=m
+CONFIG_VIDEO_IMX_PXP=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_OV5640=m
-- 
2.7.4
