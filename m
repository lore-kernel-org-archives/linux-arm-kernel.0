From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 19 Sep 2013 11:20:43 +0200
Subject: [PATCH] ASoc: kirkwood: Extend the min and max number of bytes per
 period
Message-ID: <20130919112043.5ad16147@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends the min and max number of bytes per period.
It mainly permits to reduce the sound delay in MIDI real-time playing.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index f8e1ccc..bf23afb 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -123,8 +123,8 @@
 /* need to find where they come from               */
 #define KIRKWOOD_SND_MIN_PERIODS		8
 #define KIRKWOOD_SND_MAX_PERIODS		16
-#define KIRKWOOD_SND_MIN_PERIOD_BYTES		0x4000
-#define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x4000
+#define KIRKWOOD_SND_MIN_PERIOD_BYTES		0x800
+#define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x8000
 #define KIRKWOOD_SND_MAX_BUFFER_BYTES		(KIRKWOOD_SND_MAX_PERIOD_BYTES \
 						 * KIRKWOOD_SND_MAX_PERIODS)
 
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
