From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 28 May 2013 16:47:56 +0200
Subject: [PATCH v6 08/10] ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
In-Reply-To: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1369752478-30260-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7860cc2..8528466 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -148,7 +148,7 @@ config SND_SOC_PHYCORE_AC97
 	select SND_SOC_WM9712
 	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_IMX_SSI
+	select SND_SOC_FSL_SSI
 	help
 	  Say Y if you want to add support for SoC audio on Phytec phyCORE
 	  and phyCARD boards in AC97 mode
-- 
1.8.2.1
