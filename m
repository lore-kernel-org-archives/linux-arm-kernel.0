From: shaun.ren@linux.com (Shaun Ren)
Date: Mon, 15 Feb 2016 10:58:50 -0800
Subject: [PATCH v5 RESEND 4/8] Staging: rts5208: rtsx_transport.c: Add spaces
 around -
In-Reply-To: <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
References: <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
 <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455562734-10863-5-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following styling issue in rtsx_transport.c
as reported by checkpatch.pl:

CHECK: spaces preferred around that '-' (ctx:VxV)

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 54e2027..6d2420f 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -86,8 +86,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 		while (cnt < buflen && *index < scsi_sg_count(srb)) {
 			struct page *page = sg_page(sg) +
 					((sg->offset + *offset) >> PAGE_SHIFT);
-			unsigned int poff =
-					(sg->offset + *offset) & (PAGE_SIZE-1);
+			unsigned int poff = (sg->offset + *offset) &
+					    (PAGE_SIZE - 1);
 			unsigned int sglen = sg->length - *offset;
 
 			if (sglen > buflen - cnt) {
-- 
2.7.1
