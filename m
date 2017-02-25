From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 23:54:16 +0200
Subject: [PATCH] ASoC: pxa: The open brace is placed with the previous line
Message-ID: <1488059656-16725-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/raumfeld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 552b763..47c9173 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -228,14 +228,12 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 	.codec_name	= "spi0.0",			\
 }

-static struct snd_soc_dai_link snd_soc_raumfeld_connector_dai[] =
-{
+static struct snd_soc_dai_link snd_soc_raumfeld_connector_dai[] = {
 	DAI_LINK_CS4270,
 	DAI_LINK_AK4104,
 };

-static struct snd_soc_dai_link snd_soc_raumfeld_speaker_dai[] =
-{
+static struct snd_soc_dai_link snd_soc_raumfeld_speaker_dai[] = {
 	DAI_LINK_CS4270,
 };

--
1.9.1
