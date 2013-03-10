From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:05 +0100
Subject: [PATCH 04/10] ASoC: Kconfig: imx-ssi needs imx-fiq and imx-dma
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3b98159..42d3047 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -106,6 +106,8 @@ menuconfig SND_IMX_SOC
 if SND_IMX_SOC
 
 config SND_SOC_IMX_SSI
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_IMX_PCM_FIQ
 	tristate
 
 config SND_SOC_IMX_PCM
-- 
1.8.1.5
