From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 29 Dec 2014 15:29:41 +0100
Subject: [PATCH 07/11 linux-next] [media] s5p-mfc: remove unnecessary
 version.h inclusion
In-Reply-To: <1419863387-24233-1-git-send-email-fabf@skynet.be>
References: <1419863387-24233-1-git-send-email-fabf@skynet.be>
Message-ID: <1419863387-24233-8-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on versioncheck.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 1 -
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index c6c3452..a9ef843 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/videodev2.h>
 #include <linux/workqueue.h>
 #include <media/v4l2-ctrls.h>
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index bd64f1d..68df3cd 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
-#include <linux/version.h>
 #include <linux/videodev2.h>
 #include <media/v4l2-event.h>
 #include <linux/workqueue.h>
-- 
2.1.0
