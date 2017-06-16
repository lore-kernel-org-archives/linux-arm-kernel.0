From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 15 Jun 2017 23:39:13 -0700
Subject: [PATCH RESEND 2/2] bus: arm-ccn: Enable stats for CCN-502 interconnect
In-Reply-To: <1497595153-18908-1-git-send-email-scott.branden@broadcom.com>
References: <1497595153-18908-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1497595153-18908-3-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Velibor Markovski <velibor.markovski@broadcom.com>

Add compatible string for the ARM CCN-502 interconnect

Signed-off-by: Velibor Markovski <velibor.markovski@broadcom.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
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
2.5.0
