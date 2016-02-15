From: shaun.ren@linux.com (Shaun Ren)
Date: Mon, 15 Feb 2016 10:58:51 -0800
Subject: [PATCH v5 RESEND 5/8] Staging: rts5208: rtsx_transport.c: Remove
 extra newlines
In-Reply-To: <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
References: <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
 <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455562734-10863-6-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following issues in rtsx_transport.c as reported by
checkpatch.pl:

CHECK: Blank lines aren't necessary after an open brace '{'
CHECK: Please don't use multiple blank lines

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 6d2420f..00401e2 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -91,12 +91,10 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			unsigned int sglen = sg->length - *offset;
 
 			if (sglen > buflen - cnt) {
-
 				/* Transfer ends within this s-g entry */
 				sglen = buflen - cnt;
 				*offset += sglen;
 			} else {
-
 				/* Transfer continues to next s-g entry */
 				*offset = 0;
 				++*index;
@@ -153,7 +151,6 @@ void rtsx_stor_get_xfer_buf(unsigned char *buffer,
 		scsi_set_resid(srb, scsi_bufflen(srb) - buflen);
 }
 
-
 /***********************************************************************
  * Transport routines
  ***********************************************************************/
-- 
2.7.1
