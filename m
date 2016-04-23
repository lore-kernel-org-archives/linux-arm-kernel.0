From: lipengcheng8@huawei.com (lipengcheng)
Date: Sat, 23 Apr 2016 16:45:48 +0800
Subject: [PATCH] coresight: etm4x: Add DT implementation.
Message-ID: <1461401148-188382-1-git-send-email-lipengcheng8@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT implementation for A72 board.

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 6396b28..462f0dc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -825,6 +825,11 @@ static struct amba_id etm4_ids[] = {
 		.mask	= 0x000fffff,
 		.data	= "ETM 4.0",
 	},
+	{       /* ETM 4.0 - A72, Maia, HiSilicon */
+		.id = 0x000bb95a,
+		.mask = 0x000fffff,
+		.data = "ETM 4.0",
+	},
 	{ 0, 0},
 };
 
-- 
1.8.3.2
