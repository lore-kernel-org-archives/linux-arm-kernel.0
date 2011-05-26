From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 26 May 2011 13:44:10 +0200
Subject: [PATCH 1/3] sound/atmel-pcm: trivial: typo in debug comment
In-Reply-To: <1306410252-31534-1-git-send-email-nicolas.ferre@atmel.com>
References: <1306410252-31534-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <ff83ef6ea865da7cb32921154711e672293a7d83.1306409927.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index d0e7532..51dde4e 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -382,7 +382,7 @@ static int atmel_pcm_new(struct snd_card *card,
 	}
 
 	if (dai->driver->capture.channels_min) {
-		pr_debug("at32-pcm:"
+		pr_debug("atmel-pcm:"
 				"Allocating PCM capture DMA buffer\n");
 		ret = atmel_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
-- 
1.7.3
