From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 22:25:23 +0200
Subject: [PATCH] ASoC: pxa: Add space around '='
Message-ID: <1488054323-11363-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/e750_wm9705.c    | 2 +-
 sound/soc/pxa/e800_wm9712.c    | 2 +-
 sound/soc/pxa/em-x270.c        | 2 +-
 sound/soc/pxa/mioa701_wm9713.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index fdcd94a..82bcbbb 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -81,7 +81,7 @@ static int e750_hp_amp_event(struct snd_soc_dapm_widget *w,
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name ="wm9705-aux",
+		.codec_dai_name = "wm9705-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9705-codec",
 	},
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 2df714f..1ed8aa2 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -81,7 +81,7 @@ static int e800_hp_amp_event(struct snd_soc_dapm_widget *w,
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name ="wm9712-aux",
+		.codec_dai_name = "wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
 	},
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index 6f2020f..e046770 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -43,7 +43,7 @@
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name ="wm9712-aux",
+		.codec_dai_name = "wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
 		.codec_name = "wm9712-codec",
 	},
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 8760a66..c4c6fbe 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -157,7 +157,7 @@ static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name ="wm9713-aux",
+		.codec_dai_name = "wm9713-aux",
 		.codec_name = "wm9713-codec",
 		.platform_name = "pxa-pcm-audio",
 		.ops = &mioa701_ops,
--
1.9.1
