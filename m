From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 10 Nov 2016 11:18:54 -0700
Subject: [PATCH 8/8] coresight: Add support for ARM Coresight STM-500
In-Reply-To: <1478801934-26904-1-git-send-email-mathieu.poirier@linaro.org>
References: <1478801934-26904-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1478801934-26904-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add the PIDs for STM-500 to the known STM devices list.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index d397849c2c6a..944c17b48d23 100644
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
