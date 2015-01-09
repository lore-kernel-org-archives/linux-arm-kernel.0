From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:19 -0700
Subject: [PATCH 08/11] coresight: fix typo in comment in of_coresight.c
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

Debugfs isn't used for coresight configuration, so the corresponding
comments should be changed.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
index 5030c0734508..8bd524e49518 100644
--- a/drivers/coresight/of_coresight.c
+++ b/drivers/coresight/of_coresight.c
@@ -126,7 +126,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	/* Use device name as debugfs handle */
+	/* Use device name as sysfs handle */
 	pdata->name = dev_name(dev);
 
 	/* Get the number of input and output port for this component */
-- 
1.9.1
