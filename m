From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 23:33:50 +0200
Subject: [PATCH] ASoC: pxa-ssp: Added blank line after declarations
Message-ID: <1488058430-15393-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 3bdace6..72a5e87 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -355,6 +355,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 		if (ssp->type == PXA3xx_SSP) {
 			u32 val;
 			u64 tmp = 19968;
+
 			tmp *= 1000000;
 			do_div(tmp, freq_out);
 			val = tmp;
--
1.9.1
