From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 22:42:33 +0200
Subject: [PATCH] ASoC: pxa: Add space around ':' and '('
Message-ID: <1488055353-12412-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/pxa2xx-i2s.c | 2 +-
 sound/soc/pxa/tosa.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 0389cf7..27aa0e4 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -119,7 +119,7 @@ static int pxa_i2s_wait(void)
 	int i;

 	/* flush the Rx FIFO */
-	for(i = 0; i < 16; i++)
+	for (i = 0; i < 16; i++)
 		SADR;
 	return 0;
 }
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index e022b2a..1812748 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -133,7 +133,7 @@ static int tosa_set_spk(struct snd_kcontrol *kcontrol,
 static int tosa_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(TOSA_GPIO_L_MUTE, SND_SOC_DAPM_EVENT_ON(event) ? 1 :0);
+	gpio_set_value(TOSA_GPIO_L_MUTE, SND_SOC_DAPM_EVENT_ON(event) ? 1 : 0);
 	return 0;
 }

--
1.9.1
