From: xiakaixu@huawei.com (Kaixu Xia)
Date: Wed, 31 Dec 2014 15:40:29 +0800
Subject: [PATCH] coresight: fix typo in comment in of_coresight.c
Message-ID: <1420011629-77676-1-git-send-email-xiakaixu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Debugfs isn't used for coresight configuration, so the corresponding 
comments should be changed.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
---
 drivers/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
index 5030c07..8bd524e 100644
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
1.8.5.5
