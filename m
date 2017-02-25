From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 22:57:49 +0200
Subject: [PATCH] ASoC: pxa2xx-i2s: Remove unneeded init of static variable
Message-ID: <1488056269-13324-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/pxa2xx-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 3fb60ba..744edc6 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -80,7 +80,7 @@ struct pxa_i2s_port {
 };
 static struct pxa_i2s_port pxa_i2s;
 static struct clk *clk_i2s;
-static int clk_ena = 0;
+static int clk_ena;

 static unsigned long pxa2xx_i2s_pcm_stereo_out_req = 3;
 static struct snd_dmaengine_dai_dma_data pxa2xx_i2s_pcm_stereo_out = {
--
1.9.1
