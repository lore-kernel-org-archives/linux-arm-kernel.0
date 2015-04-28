From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 28 Apr 2015 11:10:59 +0530
Subject: [PATCH] coresight: fix typo in of_coresight.c
Message-ID: <1430199659-21514-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fixes obvious typo in of_coresight.c
%s/non-configuable/non-configurable

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 35e51ce..b097361 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -37,7 +37,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 	struct device *dev = NULL;
 
 	/*
-	 * If we have a non-configuable replicator, it will be found on the
+	 * If we have a non-configurable replicator, it will be found on the
 	 * platform bus.
 	 */
 	dev = bus_find_device(&platform_bus_type, NULL,
-- 
2.2.0
