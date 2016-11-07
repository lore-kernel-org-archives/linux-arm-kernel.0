From: ping.bai@nxp.com (Bai Ping)
Date: Mon, 7 Nov 2016 13:41:19 +0800
Subject: [PATCH 1/3] driver: nvmem: Add ocotp driver support for imx6ul
Message-ID: <1478497281-5477-1-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6UL is an new SOC of i.MX6 family. Enable ocotp
driver support for this SOC.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index ac27b9b..108e4bc 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -73,6 +73,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-ocotp",  (void *)128 },
 	{ .compatible = "fsl,imx6sl-ocotp", (void *)32 },
 	{ .compatible = "fsl,imx6sx-ocotp", (void *)128 },
+	{ .compatible = "fsl,imx6ul-ocotp", (void *)128 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.8.2
