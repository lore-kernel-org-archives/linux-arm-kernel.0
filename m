From: olivier.schonken@gmail.com (Olivier Schonken)
Date: Fri,  1 Jul 2016 16:37:10 +0200
Subject: [PATCH 1/2] coresight-etm3x: Add ARM ETM-A5 peripheral ID
Message-ID: <1467383831-6985-1-git-send-email-olivier.schonken@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index d83ab82..2c6d4b4 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -885,6 +885,11 @@ static struct amba_id etm_ids[] = {
 		.mask	= 0x0003ffff,
 		.data	= "ETM 3.3",
 	},
+	{	/* ETM-A5 */
+		.id	= 0x0003b955,
+		.mask	= 0x0003ffff,
+		.data	= "ETM-A5",
+	},
 	{	/* ETM 3.5 */
 		.id	= 0x0003b956,
 		.mask	= 0x0003ffff,
-- 
1.9.1
