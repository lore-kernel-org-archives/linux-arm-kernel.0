From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 18 Jan 2018 10:45:27 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable AC97 codec support
Message-ID: <1516279527-6516-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6qdl udoo board has an AC97 codec. 

Add support for it by default.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4cb9829..80ef9ed 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -285,6 +285,7 @@ CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
 CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_SND_SOC_FSL_ASOC_CARD=y
+CONFIG_SND_SOC_AC97_CODEC=y
 CONFIG_SND_SOC_CS42XX8_I2C=y
 CONFIG_SND_SOC_TLV320AIC3X=y
 CONFIG_SND_SOC_WM8960=y
-- 
2.7.4
