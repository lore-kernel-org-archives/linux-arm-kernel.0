From: shaun.ren@linux.com (Shaun Ren)
Date: Thu, 11 Feb 2016 20:07:55 -0800
Subject: [PATCH v4 3/8] Staging: rts5208: rtsx_transport.c: Remove spaces
 after casts
In-Reply-To: <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
References: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
 <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455250080-9897-4-git-send-email-shaun.ren@linux.com>
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
index 1a4da89..1a6018a 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -72,7 +72,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	 */
 	} else {
 		struct scatterlist *sg =
-				(struct scatterlist *) scsi_sglist(srb)
+				(struct scatterlist *)scsi_sglist(srb)
 				+ *index;
 
 		/*
-- 
2.7.0
