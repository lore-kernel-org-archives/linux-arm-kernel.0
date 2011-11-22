From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Nov 2011 11:55:52 +0100
Subject: [PATCH 1/3] dmaengine: at_hdmac: add const to struct
 platform_device_id definition
Message-ID: <25000153a64c2845223be78ee55e01e034613601.1321959137.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 3b0c28f..3b44f24 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1191,7 +1191,7 @@ static const struct of_device_id atmel_dma_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, atmel_dma_dt_ids);
 #endif
 
-static struct platform_device_id atdma_devtypes[] = {
+static const struct platform_device_id atdma_devtypes[] = {
 	{
 		.name = "at91sam9rl_dma",
 		.driver_data = ATDMA_DEVTYPE_SAM9RL,
-- 
1.7.5.4
