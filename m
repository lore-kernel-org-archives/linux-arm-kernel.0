From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  2 Feb 2016 14:13:55 -0700
Subject: [PATCH 1/7] coresight: fixing indentation problem
In-Reply-To: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
References: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1454447641-29153-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 93738dfbf631..4236a02cdab2 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -536,7 +536,7 @@ static void coresight_fixup_orphan_conns(struct coresight_device *csdev)
 	 * are hooked-up with each newly added component.
 	 */
 	bus_for_each_dev(&coresight_bustype, NULL,
-				 csdev, coresight_orphan_match);
+			 csdev, coresight_orphan_match);
 }
 
 
-- 
2.1.4
