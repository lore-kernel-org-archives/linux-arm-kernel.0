From: lipengcheng8@huawei.com (lipengcheng)
Date: Mon, 18 Apr 2016 16:41:59 +0800
Subject: [PATCH] coresight: etm4x: Add DT implementation.
Message-ID: <1460968919-136371-1-git-send-email-lipengcheng8@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT implementation for A72 and Atermis board.

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 6396b28..76bfad1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -825,6 +825,16 @@ static struct amba_id etm4_ids[] = {
 		.mask	= 0x000fffff,
 		.data	= "ETM 4.0",
 	},
+	{       /* ETM 4.0 - A72 board */
+		.id = 0x000bb95a,
+		.mask = 0x000fffff,
+		.data = "ETM 4.0",
+	},
+	{       /* ETM 4.0 - Atermis board */
+		.id = 0x000bb959,
+		.mask = 0x000fffff,
+		.data = "ETM 4.0",
+	},
 	{ 0, 0},
 };
 
-- 
1.8.3.2
