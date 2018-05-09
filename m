From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  9 May 2018 12:06:07 -0600
Subject: [PATCH 5/6] coresight tmc etr: Removing extra newline
In-Reply-To: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
References: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1525889168-20574-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple removal of an extra newline, no change in functionality.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f57199580c11..02f747afa2ba 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -116,7 +116,6 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	dma_addr_t paddr = 0;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-
 	/*
 	 * If we don't have a buffer release the lock and allocate memory.
 	 * Otherwise keep the lock and move along.
-- 
2.7.4
