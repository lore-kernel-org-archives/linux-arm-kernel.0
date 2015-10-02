From: ingi2.kim@samsung.com (Ingi Kim)
Date: Fri, 02 Oct 2015 18:00:17 +0900
Subject: [PATCH 1/2] s5p-mfc: fix spelling errors
Message-ID: <1443776417-13083-1-git-send-email-ingi2.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes spelling errors in mfc encoder.
inavild -> invaild

Signed-off-by: Ingi Kim <ingi2.kim@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index 2e57e9f..3a84021 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -1821,7 +1821,7 @@ static int s5p_mfc_queue_setup(struct vb2_queue *vq,
 
 	if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (ctx->state != MFCINST_GOT_INST) {
-			mfc_err("inavlid state: %d\n", ctx->state);
+			mfc_err("invalid state: %d\n", ctx->state);
 			return -EINVAL;
 		}
 
@@ -1861,7 +1861,7 @@ static int s5p_mfc_queue_setup(struct vb2_queue *vq,
 				ctx->dev->alloc_ctx[MFC_BANK2_ALLOC_CTX];
 		}
 	} else {
-		mfc_err("inavlid queue type: %d\n", vq->type);
+		mfc_err("invalid queue type: %d\n", vq->type);
 		return -EINVAL;
 	}
 	return 0;
@@ -1895,7 +1895,7 @@ static int s5p_mfc_buf_init(struct vb2_buffer *vb)
 					vb2_dma_contig_plane_dma_addr(vb, 1);
 		ctx->src_bufs_cnt++;
 	} else {
-		mfc_err("inavlid queue type: %d\n", vq->type);
+		mfc_err("invalid queue type: %d\n", vq->type);
 		return -EINVAL;
 	}
 	return 0;
@@ -1931,7 +1931,7 @@ static int s5p_mfc_buf_prepare(struct vb2_buffer *vb)
 			return -EINVAL;
 		}
 	} else {
-		mfc_err("inavlid queue type: %d\n", vq->type);
+		mfc_err("invalid queue type: %d\n", vq->type);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.0.5
