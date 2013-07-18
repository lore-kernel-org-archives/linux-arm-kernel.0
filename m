From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 18 Jul 2013 14:38:20 +0800
Subject: [PATCH] ASoC: wm8904: fix the typo error for LINER Mux
Message-ID: <1374129500-5270-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix the typo error, from "LINEL Mux" to "LINER Mux"

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/codecs/wm8904.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 3ff195c..bdd575a 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1017,7 +1017,7 @@ static const struct soc_enum liner_enum =
 	SOC_ENUM_SINGLE(WM8904_ANALOGUE_OUT12_ZC, 0, 2, out_mux_text);
 
 static const struct snd_kcontrol_new liner_mux =
-	SOC_DAPM_ENUM("LINEL Mux", liner_enum);
+	SOC_DAPM_ENUM("LINER Mux", liner_enum);
 
 static const char *sidetone_text[] = {
 	"None", "Left", "Right"
-- 
1.7.9.5
