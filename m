From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 8 Dec 2014 11:58:29 +0100
Subject: [PATCH] ASoC: atmel_ssc_dai/trivial: typo fix
Message-ID: <1418036309-28695-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthieu Crapet <mcrapet@gmail.com>

Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index f403f399808a..775a2badd6a4 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -267,7 +267,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 	if (!ssc_p->dir_mask) {
 		if (ssc_p->initialized) {
 			/* Shutdown the SSC clock. */
-			pr_debug("atmel_ssc_dau: Stopping clock\n");
+			pr_debug("atmel_ssc_dai: Stopping clock\n");
 			clk_disable(ssc_p->ssc->clk);
 
 			free_irq(ssc_p->ssc->irq, ssc_p);
-- 
2.1.3
