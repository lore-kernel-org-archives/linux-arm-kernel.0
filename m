From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 13 Nov 2014 14:12:47 +0530
Subject: [PATCH 1/3] coresight: fix typo in comment in coresight-priv.h
In-Reply-To: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
References: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1415868169-13325-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fixes a typo %s/eveyone/everyone/ in function CS_UNLOCK.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/coresight/coresight-priv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-priv.h b/drivers/coresight/coresight-priv.h
index 8d1180c..7b3372f 100644
--- a/drivers/coresight/coresight-priv.h
+++ b/drivers/coresight/coresight-priv.h
@@ -47,7 +47,7 @@ static inline void CS_UNLOCK(void __iomem *addr)
 {
 	do {
 		writel_relaxed(CORESIGHT_UNLOCK, addr + CORESIGHT_LAR);
-		/* Make sure eveyone has seen this */
+		/* Make sure everyone has seen this */
 		mb();
 	} while (0);
 }
-- 
1.7.9.5
