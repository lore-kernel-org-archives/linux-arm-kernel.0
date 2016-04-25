From: eric.engestrom@imgtec.com (Eric Engestrom)
Date: Mon, 25 Apr 2016 10:47:56 +0100
Subject: [PATCH 3/4] dmaengine: pxa_dma: remove duplicate const qualifier
In-Reply-To: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
Message-ID: <1461577678-29517-3-git-send-email-eric.engestrom@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Engestrom <eric.engestrom@imgtec.com>
---
 drivers/dma/pxa_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 77c1c44..315901d 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1321,7 +1321,7 @@ static int pxad_init_phys(struct platform_device *op,
 	return 0;
 }
 
-static const struct of_device_id const pxad_dt_ids[] = {
+static const struct of_device_id pxad_dt_ids[] = {
 	{ .compatible = "marvell,pdma-1.0", },
 	{}
 };
-- 
2.7.4
