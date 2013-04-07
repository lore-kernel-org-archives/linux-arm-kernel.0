From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:25:19 +0200
Subject: [PATCH v2 09/11] ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
In-Reply-To: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365362721-3731-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3b98159..5ace408 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -153,7 +153,7 @@ config SND_SOC_PHYCORE_AC97
 	select SND_SOC_WM9712
 	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_IMX_SSI
+	select SND_SOC_FSL_SSI
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
-- 
1.8.1.5
