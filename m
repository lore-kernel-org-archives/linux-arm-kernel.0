From: shaun.ren@linux.com (Shaun Ren)
Date: Mon, 15 Feb 2016 10:58:49 -0800
Subject: [PATCH v5 RESEND 3/8] Staging: rts5208: rtsx_transport.c: Remove
 spaces after casts
In-Reply-To: <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
References: <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
 <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455562734-10863-4-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes all spaces after casts in rtsx_transport.c, as reported
by checkpatch.pl:

CHECK: No space is necessary after a cast

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index b6de93f..54e2027 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -73,7 +73,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	 */
 	} else {
 		struct scatterlist *sg =
-				(struct scatterlist *) scsi_sglist(srb)
+				(struct scatterlist *)scsi_sglist(srb)
 				+ *index;
 
 		/*
-- 
2.7.1
