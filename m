From: velibor.markovski@broadcom.com (Velibor Markovski)
Date: Fri, 10 Feb 2017 12:42:48 -0800
Subject: [PATCH 2/2] bus: arm-ccn: Enable stats for CCN-502 interconnect
In-Reply-To: <1486759368-24067-1-git-send-email-velibor.markovski@broadcom.com>
References: <1486759368-24067-1-git-send-email-velibor.markovski@broadcom.com>
Message-ID: <1486759368-24067-3-git-send-email-velibor.markovski@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string for the ARM CCN-502 interconnect

Signed-off-by: Velibor Markovski <velibor.markovski@broadcom.com>
---
 drivers/bus/arm-ccn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 4d6a2b7..98a6995 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -1544,6 +1544,7 @@ static int arm_ccn_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id arm_ccn_match[] = {
+	{ .compatible = "arm,ccn-502", },
 	{ .compatible = "arm,ccn-504", },
 	{},
 };
-- 
1.9.1
