From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 24 Jan 2012 13:52:18 +0200
Subject: [PATCH v4 - resend 01/13] ASoC: sdp4430: Correct author e-mail address
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1327405950-6676-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/sdp4430.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 175ba9a..ceadb13 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -1,7 +1,7 @@
 /*
  * sdp4430.c  --  SoC audio for TI OMAP4430 SDP
  *
- * Author: Misael Lopez Cruz <x0052729@ti.com>
+ * Author: Misael Lopez Cruz <misael.lopez@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -273,7 +273,7 @@ static void __exit sdp4430_soc_exit(void)
 }
 module_exit(sdp4430_soc_exit);
 
-MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
+MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_DESCRIPTION("ALSA SoC SDP4430");
 MODULE_LICENSE("GPL");
 
-- 
1.7.8.3
