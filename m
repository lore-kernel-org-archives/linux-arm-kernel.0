From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 11 Sep 2011 12:28:49 +0300
Subject: [PATCH 1/7] ASoC: ep93xx-pcm: add MODULE_ALIAS
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Message-ID: <d678a0075d114443bd0821f5eef84669ad879048.1315732452.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get the PCM module loaded automatically by udev et al. we need to add a
proper MODULE_ALIAS.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 sound/soc/ep93xx/ep93xx-pcm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
index 8dfd3ad..d00230a 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.c
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -355,3 +355,4 @@ module_exit(ep93xx_soc_platform_exit);
 MODULE_AUTHOR("Ryan Mallon");
 MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ep93xx-pcm-audio");
-- 
1.7.5.4
