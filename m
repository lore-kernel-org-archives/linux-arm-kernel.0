From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 29 Dec 2014 15:29:40 +0100
Subject: [PATCH 06/11 linux-next] [media] s5p-g2d: remove unnecessary
 version.h inclusion
In-Reply-To: <1419863387-24233-1-git-send-email-fabf@skynet.be>
References: <1419863387-24233-1-git-send-email-fabf@skynet.be>
Message-ID: <1419863387-24233-7-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on versioncheck.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/media/platform/s5p-g2d/g2d.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
index 47ba8fb..ec3e124 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -12,7 +12,6 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/version.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-- 
2.1.0
