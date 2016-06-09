From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed,  8 Jun 2016 21:57:34 -0400
Subject: [PATCH 1/2] [media] s5p-mfc: fix typo in s5p_mfc_dec function comment
Message-ID: <1465437455-24110-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function comment has an obvious typo error, so fix it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index a01a373a4c4f..8e2ee1a0df2b 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -564,7 +564,7 @@ out:
 	return ret;
 }
 
-/* Reqeust buffers */
+/* Request buffers */
 static int vidioc_reqbufs(struct file *file, void *priv,
 					  struct v4l2_requestbuffers *reqbufs)
 {
-- 
2.5.5
