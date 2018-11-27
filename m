From: colin.king@canonical.com (Colin King)
Date: Tue, 27 Nov 2018 14:03:56 +0000
Subject: [PATCH] coresight: fix spelling mistake "deffered" -> "deferred"
Message-ID: <20181127140356.26626-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the dev_info error message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 35d6f9709274..ef339ff22090 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -856,7 +856,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
 		dev_info(dev,
-			 "stm_register_device failed, probing deffered\n");
+			 "stm_register_device failed, probing deferred\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.19.1
