From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:01:18 +0900
Subject: [PATCH 1/7] S3C64XX DMA: struct s3c64xx_dma_buff debugged
Message-ID: <1253008878-7490-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'struct pl080s_lli' should be the member of struct s3c64xx_dma_buff
rather than 'struct pl080_lli'.
Corrected the typo mistake.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/include/plat/dma-plat.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/dma-plat.h b/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
index 0c30dd9..8f76a1e 100644
--- a/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
+++ b/arch/arm/plat-s3c64xx/include/plat/dma-plat.h
@@ -26,7 +26,7 @@ struct s3c64xx_dma_buff {
 	struct s3c64xx_dma_buff *next;
 
 	void			*pw;
-	struct pl080_lli	*lli;
+	struct pl080s_lli	*lli;
 	dma_addr_t		 lli_dma;
 };
 
-- 
1.6.2.5
