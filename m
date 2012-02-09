From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu,  9 Feb 2012 16:33:54 +0100
Subject: [PATCH 2/2] mmc: atmel-mci: fix typo
In-Reply-To: <7ef1b8ff1e9425fc99bd737faaa9f63aa4f4f8b4.1328801500.git.ludovic.desroches@atmel.com>
References: <7ef1b8ff1e9425fc99bd737faaa9f63aa4f4f8b4.1328801500.git.ludovic.desroches@atmel.com>
Message-ID: <e3d27dde7a46fcd0e440e17e4a66469f6b22697f.1328801500.git.ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e71a158..09ac13b 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1968,7 +1968,7 @@ static bool atmci_configure_dma(struct atmel_mci *host)
 		return false;
 	} else {
 		dev_info(&host->pdev->dev,
-					"Using %s for DMA transfers\n",
+					"using %s for DMA transfers\n",
 					dma_chan_name(host->dma.chan));
 		return true;
 	}
-- 
1.7.5.4
