From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:47 +0200
Subject: [PATCH v3 03/15] ASoC: dmaengine-pcm: Fix function name
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutrnoix.de>

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 2e25402..f752577 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -50,7 +50,8 @@ int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	snd_dmaengine_set_config_from_dai_data(substream, dma_data, slave_config);
+	snd_dmaengine_pcm_set_config_from_dai_data(substream, dma_data,
+			slave_config);
 
 	return 0;
 }
-- 
1.8.1.5
