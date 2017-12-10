From: pravin.shedge4linux@gmail.com (Pravin Shedge)
Date: Mon, 11 Dec 2017 00:02:03 +0530
Subject: [PATCH 43/45] sound/soc/zte: remove duplicate includes
Message-ID: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 sound/soc/zte/zx-i2s.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index 9a05659..93428e1 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -20,9 +20,6 @@
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/initval.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
 
 #define ZX_I2S_PROCESS_CTRL	0x04
 #define ZX_I2S_TIMING_CTRL	0x08
-- 
2.7.4
