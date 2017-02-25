From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 23:40:31 +0200
Subject: [PATCH] ASoC: pxa-ssp: Line up *s in block comments
Message-ID: <1488058831-15912-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 72a5e87..f3285a6 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -592,13 +592,13 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,

 		if ((pxa_ssp_get_scr(ssp) == 4) && (width == 16)) {
 			/* This is a special case where the bitclk is 64fs
-			* and we're not dealing with 2*32 bits of audio
-			* samples.
-			*
-			* The SSP values used for that are all found out by
-			* trying and failing a lot; some of the registers
-			* needed for that mode are only available on PXA3xx.
-			*/
+			 * and we're not dealing with 2*32 bits of audio
+			 * samples.
+			 *
+			 * The SSP values used for that are all found out by
+			 * trying and failing a lot; some of the registers
+			 * needed for that mode are only available on PXA3xx.
+			 */
 			if (ssp->type != PXA3xx_SSP)
 				return -EINVAL;

--
1.9.1
