From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 22:33:00 +0200
Subject: [PATCH] ASoC: pxa: Remove space before semicolon
Message-ID: <1488054780-11831-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/spitz.c | 4 ++--
 sound/soc/pxa/z2.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 07d77cd..d38a2b5 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -230,8 +230,8 @@ static int spitz_mic_bias(struct snd_soc_dapm_widget *w,
 	{"Headset Jack", NULL, "ROUT1"},

 	/* ext speaker connected to LOUT2, ROUT2  */
-	{"Ext Spk", NULL , "ROUT2"},
-	{"Ext Spk", NULL , "LOUT2"},
+	{"Ext Spk", NULL, "ROUT2"},
+	{"Ext Spk", NULL, "LOUT2"},

 	/* mic is connected to input 1 - with bias */
 	{"LINPUT1", NULL, "Mic Bias"},
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 990b1aa..6d88d9a 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -119,8 +119,8 @@ static int z2_hw_params(struct snd_pcm_substream *substream,
 	{"Headphone Jack", NULL, "ROUT1"},

 	/* ext speaker connected to LOUT2, ROUT2  */
-	{"Ext Spk", NULL , "ROUT2"},
-	{"Ext Spk", NULL , "LOUT2"},
+	{"Ext Spk", NULL, "ROUT2"},
+	{"Ext Spk", NULL, "LOUT2"},

 	/* mic is connected to R input 2 - with bias */
 	{"RINPUT2", NULL, "Mic Bias"},
--
1.9.1
