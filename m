From: peng.fan@nxp.com (Peng Fan)
Date: Wed, 1 Mar 2017 14:40:54 +0800
Subject: [PATCH 3/3] nvmem: octop: Add i.MX7D support
In-Reply-To: <1488350454-23860-1-git-send-email-peng.fan@nxp.com>
References: <1488350454-23860-1-git-send-email-peng.fan@nxp.com>
Message-ID: <1488350454-23860-3-git-send-email-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX7D support.
There is 16 banks, each bank 4 words.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 drivers/nvmem/imx-ocotp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index b8ca1e6..41550ba 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -74,6 +74,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6sl-ocotp", (void *)64 },
 	{ .compatible = "fsl,imx6sx-ocotp", (void *)128 },
 	{ .compatible = "fsl,imx6ul-ocotp", (void *)128 },
+	{ .compatible = "fsl,imx7d-ocotp", (void *)64 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.6.6
