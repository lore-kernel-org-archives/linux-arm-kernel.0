From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  2 Nov 2016 16:19:51 +0000
Subject: [PATCH] coresight: Add support for ARM Coresight STM-500
Message-ID: <1478103591-7662-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PIDs for STM-500 to the known STM devices list.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 49e0f1b..3524452 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -920,6 +920,11 @@ static struct amba_id stm_ids[] = {
 		.mask   = 0x0003ffff,
 		.data	= "STM32",
 	},
+	{
+		.id	= 0x0003b963,
+		.mask	= 0x0003ffff,
+		.data	= "STM500",
+	},
 	{ 0, 0},
 };
 
-- 
2.7.4
