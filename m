From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Sat, 13 Sep 2014 05:00:53 +0800
Subject: [Patch v4 net-next 08/12] net:fec: Add fsl,
 imx6sx-fec  compatible strings
In-Reply-To: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
References: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1410555657-10744-9-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fugang Duan <B38611@freescale.com>

Add compatible string "fsl,imx6sx-fec" for i.MX6SX.

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 658b0b3..0cc7313 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -157,6 +157,7 @@ enum imx_fec_type {
 	IMX28_FEC,
 	IMX6Q_FEC,
 	MVF600_FEC,
+	IMX6SX_FEC,
 };
 
 static const struct of_device_id fec_dt_ids[] = {
@@ -165,6 +166,7 @@ static const struct of_device_id fec_dt_ids[] = {
 	{ .compatible = "fsl,imx28-fec", .data = &fec_devtype[IMX28_FEC], },
 	{ .compatible = "fsl,imx6q-fec", .data = &fec_devtype[IMX6Q_FEC], },
 	{ .compatible = "fsl,mvf600-fec", .data = &fec_devtype[MVF600_FEC], },
+	{ .compatible = "fsl,imx6sx-fec", .data = &fec_devtype[IMX6SX_FEC], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fec_dt_ids);
-- 
1.9.1
