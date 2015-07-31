From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 31 Jul 2015 09:37:22 -0600
Subject: [PATCH 02/10] coresight-etm3x: Add Qualcomm PTM v1.1 peripheral ID
In-Reply-To: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
References: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1438357050-22486-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>

Add Qualcomm's PTM v1.1 peripheral ID to supported devices.
This device could be found at least in MSM8974 and APQ8064
chipsets.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 018a00fda611..cca98a8b2527 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1912,6 +1912,11 @@ static struct amba_id etm_ids[] = {
 		.mask	= 0x0003ffff,
 		.data	= "PTM 1.1",
 	},
+	{	/* PTM 1.1 Qualcomm */
+		.id	= 0x0003006f,
+		.mask	= 0x0003ffff,
+		.data	= "PTM 1.1",
+	},
 	{ 0, 0},
 };
 
-- 
1.9.1
