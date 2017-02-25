From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 23:06:36 +0200
Subject: [PATCH] ASoC: pxa: Remove unneeded return statement in void function
Message-ID: <1488056796-13873-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/mmp-pcm.c  | 1 -
 sound/soc/pxa/mmp-sspa.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 96df9b2..5b5f1a4 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -166,7 +166,6 @@ static void mmp_pcm_free_dma_buffers(struct snd_pcm *pcm)
 		buf->area = NULL;
 	}

-	return;
 }

 static int mmp_pcm_preallocate_dma_buffer(struct snd_pcm_substream *substream,
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index ca8b23f..9cc3501 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -119,7 +119,6 @@ static void mmp_sspa_shutdown(struct snd_pcm_substream *substream,
 	clk_disable(priv->sspa->clk);
 	clk_disable(priv->sysclk);

-	return;
 }

 /*
--
1.9.1
