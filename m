From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Wed, 20 May 2015 18:02:25 +0300
Subject: [PATCH] coresight-etm3x: Add Qualcomm PFT v1.1 peripheral ID
Message-ID: <1432134145-28298-1-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Qualcomm's PFT v1.1 peripheral ID to supported devices.
This device could be found at least in MSM8974 and APQ8064
chipsets.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 018a00f..e13520f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1912,6 +1912,11 @@ static struct amba_id etm_ids[] = {
 		.mask	= 0x0003ffff,
 		.data	= "PTM 1.1",
 	},
+	{	/* PFT 1.1 Qualcomm */
+		.id	= 0x0003006f,
+		.mask	= 0x0003ffff,
+		.data	= "PFT 1.1",
+	},
 	{ 0, 0},
 };

--
1.9.1
