From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 17 Jun 2015 15:28:06 +0100
Subject: [PATCH v2 5/7] block/xen-blkfront: Remove unused macro
 MAXIMUM_OUTSTANDING_BLOCK_REQS
In-Reply-To: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
References: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1434551288-14113-6-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@linaro.org>

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Acked-by: Roger Pau Monn? <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

---
    Changes in v2:
        - Add Roger's Acked-by
---
 drivers/block/xen-blkfront.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 2c61cf8..5c72c25 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -139,8 +139,6 @@ static unsigned int nr_minors;
 static unsigned long *minors;
 static DEFINE_SPINLOCK(minor_lock);
 
-#define MAXIMUM_OUTSTANDING_BLOCK_REQS \
-	(BLKIF_MAX_SEGMENTS_PER_REQUEST * BLK_RING_SIZE)
 #define GRANT_INVALID_REF	0
 
 #define PARTS_PER_DISK		16
-- 
2.1.4
