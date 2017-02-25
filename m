From: codrut.cristian.grosu@gmail.com (Codrut Grosu)
Date: Sat, 25 Feb 2017 12:39:48 +0200
Subject: [PATCH] ASoC: sun4i-codec: Remove spaces before tabs.
Message-ID: <1488019188-15408-1-git-send-email-codrut.cristian.grosu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index c3aab10..7ba6849 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1139,8 +1139,8 @@ static int sun4i_codec_dai_probe(struct snd_soc_dai *dai)
 		.stream_name	= "Capture",
 		.channels_min	= 1,
 		.channels_max	= 2,
-		.rates 		= SUN4I_CODEC_RATES,
-		.formats 	= SUN4I_CODEC_FORMATS,
+		.rates		= SUN4I_CODEC_RATES,
+		.formats	= SUN4I_CODEC_FORMATS,
 		.sig_bits	= 24,
 	 },
 };
-- 
1.9.1
