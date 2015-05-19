From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 May 2015 10:55:20 -0600
Subject: [PATCH 15/16] coresight: fix typo in of_coresight.c
In-Reply-To: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
References: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1432054521-24807-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

fixes obvious typo in of_coresight.c
%s/non-configuable/non-configurable

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 35e51ce93a5c..b0973617826f 100644
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
1.9.1
