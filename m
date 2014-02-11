From: b44548@freescale.com (Chao Fu)
Date: Tue, 11 Feb 2014 13:48:17 +0800
Subject: [PATCH v3 2/2] spi:dspi:Remove some coding sytle not in standard
In-Reply-To: <1392097697-14919-1-git-send-email-b44548@freescale.com>
References: <1392097697-14919-1-git-send-email-b44548@freescale.com>
Message-ID: <1392097697-14919-2-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

Remove some coding sytle not in standard in former code.

Signed-off-by: Chao Fu      <b44548@freescale.com>
---
Change in v3:
None.
Change in v2:
New.

 drivers/spi/spi-fsl-dspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index fb16575..42ede0d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -111,9 +111,9 @@ struct fsl_dspi {
 
 	struct regmap		*regmap;
 	int			irq;
-	struct clk 		*clk;
+	struct clk		*clk;
 
-	struct spi_transfer 	*cur_transfer;
+	struct spi_transfer	*cur_transfer;
 	struct chip_data	*cur_chip;
 	size_t			len;
 	void			*tx;
@@ -124,8 +124,8 @@ struct fsl_dspi {
 	u8			cs;
 	u16			void_write_data;
 
-	wait_queue_head_t 	waitq;
-	u32 			waitflags;
+	wait_queue_head_t	waitq;
+	u32			waitflags;
 };
 
 static inline int is_double_byte_mode(struct fsl_dspi *dspi)
-- 
1.8.4
