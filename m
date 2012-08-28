From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:02 +0200
Subject: [PATCH 1/8] sound: kirkwood: remove useless <plat/audio.h> include
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346180349-25123-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kirkwood-openrd.c and kirkwood-t5325.c are not using the platform_data
structure defined in <plat/audio.h>, so there's no point in including
this header file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 sound/soc/kirkwood/kirkwood-openrd.c |    1 -
 sound/soc/kirkwood/kirkwood-t5325.c  |    1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 80bd59c..98a9157 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <mach/kirkwood.h>
-#include <plat/audio.h>
 #include <asm/mach-types.h>
 #include "../codecs/cs42l51.h"
 
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index f898363..5213ee9 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -16,7 +16,6 @@
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <mach/kirkwood.h>
-#include <plat/audio.h>
 #include <asm/mach-types.h>
 #include "../codecs/alc5623.h"
 
-- 
1.7.9.5
