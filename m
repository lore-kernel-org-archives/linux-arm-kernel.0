From: joe@perches.com (Joe Perches)
Date: Sun, 14 Nov 2010 19:04:47 -0800
Subject: [PATCH 28/44] drivers/spi: Remove unnecessary semicolons
In-Reply-To: <cover.1289789604.git.joe@perches.com>
References: <cover.1289789604.git.joe@perches.com>
Message-ID: <fe5e5e0efbd97eaa32530eef5ed47efdc3252dad.1289789605.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/spi/amba-pl022.c |    2 +-
 drivers/spi/spi_nuc900.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index fb3d1b3..2e50631 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -956,7 +956,7 @@ static int configure_dma(struct pl022 *pl022)
 		tx_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	case WRITING_U32:
-		tx_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;;
+		tx_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	}
 
diff --git a/drivers/spi/spi_nuc900.c b/drivers/spi/spi_nuc900.c
index dff63be..d5be18b 100644
--- a/drivers/spi/spi_nuc900.c
+++ b/drivers/spi/spi_nuc900.c
@@ -449,7 +449,7 @@ err_iomap:
 	release_mem_region(hw->res->start, resource_size(hw->res));
 	kfree(hw->ioarea);
 err_pdata:
-	spi_master_put(hw->master);;
+	spi_master_put(hw->master);
 
 err_nomem:
 	return err;
-- 
1.7.3.1.g432b3.dirty
