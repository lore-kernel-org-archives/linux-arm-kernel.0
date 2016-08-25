From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 15:19:03 -0600
Subject: [PATCH 13/28] coresight-etm3x: Add ARM ETM 3.5 Cortex-A5 peripheral ID
In-Reply-To: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472159958-5981-14-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olivier Schonken <olivier.schonken@gmail.com>

Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 2de4cad9c5ed..b4f380a9da5c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -893,6 +893,11 @@ static struct amba_id etm_ids[] = {
 		.mask	= 0x0003ffff,
 		.data	= "ETM 3.3",
 	},
+	{	/* ETM 3.5 - Cortex-A5 */
+		.id	= 0x0003b955,
+		.mask	= 0x0003ffff,
+		.data	= "ETM 3.5",
+	},
 	{	/* ETM 3.5 */
 		.id	= 0x0003b956,
 		.mask	= 0x0003ffff,
-- 
2.7.4
