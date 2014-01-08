From: b44548@freescale.com (Chao Fu)
Date: Wed, 8 Jan 2014 14:14:15 +0800
Subject: [PATCH v2 2/2] spi:dspi:Remove some coding sytle not in standard
In-Reply-To: <1389161655-21856-1-git-send-email-b44548@freescale.com>
References: <1389161655-21856-1-git-send-email-b44548@freescale.com>
Message-ID: <1389161655-21856-2-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

Remove some coding sytle not in standard in former code.

Signed-off-by: Chao Fu      <b44548@freescale.com>
---
Change in v2:
	New.

 drivers/spi/spi-fsl-dspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 1cd6d79..76cd521 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -113,10 +113,10 @@ struct fsl_dspi {
 
 	void __iomem		*base;
 	int			irq;
-	struct clk 		*clk;
+	struct clk		*clk;
 
 	bool			big_endian;
-	struct spi_transfer 	*cur_transfer;
+	struct spi_transfer	*cur_transfer;
 	struct chip_data	*cur_chip;
 	size_t			len;
 	void			*tx;
@@ -127,8 +127,8 @@ struct fsl_dspi {
 	u8			cs;
 	u16			void_write_data;
 
-	wait_queue_head_t 	waitq;
-	u32 			waitflags;
+	wait_queue_head_t	waitq;
+	u32			waitflags;
 };
 
 static inline u8 dspi_readb(void __iomem *addr)
-- 
1.8.4
