From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:04:55 +0100
Subject: [PATCH 04/16] dmaengine: pl08x: Enable module alias autogeneration
	for AMBA drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-5-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/dma/amba-pl08x.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b7cbd1a..0698695 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2054,6 +2054,8 @@ static struct amba_id pl08x_ids[] = {
 	{ 0, 0 },
 };
 
+MODULE_DEVICE_TABLE(amba, pl08x_ids);
+
 static struct amba_driver pl08x_amba_driver = {
 	.drv.name	= DRIVER_NAME,
 	.id_table	= pl08x_ids,
-- 
1.7.4.1
