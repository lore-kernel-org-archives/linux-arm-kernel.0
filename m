From: ping.bai@nxp.com (Bai Ping)
Date: Thu, 17 Nov 2016 09:08:17 +0800
Subject: [PATCH v2 1/3] driver: nvmem: Add ocotp driver support for imx6ul
Message-ID: <1479344899-3141-1-git-send-email-ping.bai@nxp.com>
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
@@ -73,6 +73,7 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 	{ .compatible = "fsl,imx6q-ocotp",  (void *)128 },
 	{ .compatible = "fsl,imx6sl-ocotp", (void *)32 },
 	{ .compatible = "fsl,imx6sx-ocotp", (void *)128 },
+	{ .compatible = "fsl,imx6ul-ocotp", (void *)128 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
1.9.1
