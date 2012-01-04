From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Wed, 4 Jan 2012 12:47:49 +0530
Subject: [PATCH v8 2/2] davinci: CQ93VC: remove machine specific header file
 inclusion from codec driver
In-Reply-To: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
References: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <1325661469-4411-3-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove unnecessary inclusion of machine specific header
file mach/dm365.h from cq93vc.c voice codec driver
which comes in the way of platform code consolidation.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
Cc: <alsa-devel@alsa-project.org>
Cc: <linux-kernel@vger.kernel.org>
---
 sound/soc/codecs/cq93vc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 46dbfd0..ff4eb7a 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -38,8 +38,6 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 
-#include <mach/dm365.h>
-
 static inline unsigned int cq93vc_read(struct snd_soc_codec *codec,
 						unsigned int reg)
 {
-- 
1.6.2.4
