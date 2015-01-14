From: xiakaixu@huawei.com (Kaixu Xia)
Date: Wed, 14 Jan 2015 20:04:47 +0800
Subject: [PATCH] coresight: fix the parameter name of etm_writel_cp14()
Message-ID: <1421237087-68021-1-git-send-email-xiakaixu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This minor change is necessary to make more sense.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
---
 drivers/coresight/coresight-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-priv.h b/drivers/coresight/coresight-priv.h
index 7b3372f..62fcd98 100644
--- a/drivers/coresight/coresight-priv.h
+++ b/drivers/coresight/coresight-priv.h
@@ -57,7 +57,7 @@ extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
 #else
 static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
-static inline int etm_writel_cp14(u32 val, u32 off) { return 0; }
+static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 #endif
 
 #endif
-- 
1.8.5.5
