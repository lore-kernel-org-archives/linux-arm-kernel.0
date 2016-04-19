From: van.freenix@gmail.com (Peng Fan)
Date: Tue, 19 Apr 2016 16:59:14 +0800
Subject: [PATCH 3/3] nvmem: imx-ocotp: support i.MX6UL
In-Reply-To: <1461056354-973-1-git-send-email-van.freenix@gmail.com>
References: <1461056354-973-1-git-send-email-van.freenix@gmail.com>
Message-ID: <1461056354-973-3-git-send-email-van.freenix@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_device_id entry for i.MX6UL to let imx-ocotp driver
support i.MX6UL.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 drivers/nvmem/imx-ocotp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 55095c0..4c6e05a 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -96,6 +96,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-ocotp",  (void *)128 },
 	{ .compatible = "fsl,imx6sl-ocotp", (void *)32 },
 	{ .compatible = "fsl,imx6sx-ocotp", (void *)128 },
+	{ .compatible = "fsl,imx6ul-ocotp", (void *)128 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
1.8.4.5
