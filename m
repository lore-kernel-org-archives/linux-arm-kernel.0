From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Nov 2011 11:55:53 +0100
Subject: [PATCH 2/3] dmaengine: at_hdmac: empty entry shape modification
In-Reply-To: <25000153a64c2845223be78ee55e01e034613601.1321959137.git.nicolas.ferre@atmel.com>
References: <25000153a64c2845223be78ee55e01e034613601.1321959137.git.nicolas.ferre@atmel.com>
Message-ID: <ead9d5af63c24616a9e88fce3ca72860207477ca.1321959137.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial form modification to unify structure look.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 3b44f24..30ec030 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1185,7 +1185,9 @@ static const struct of_device_id atmel_dma_dt_ids[] = {
 	}, {
 		.compatible = "atmel,at91sam9g45-dma",
 		.data = (void *)ATDMA_DEVTYPE_SAM9G45
-	}, { /* sentinel */ }
+	}, {
+		/* sentinel */
+	}
 };
 
 MODULE_DEVICE_TABLE(of, atmel_dma_dt_ids);
-- 
1.7.5.4
