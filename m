From: aravind.thk@gmail.com (Aravind Thokala)
Date: Mon, 19 Jun 2017 22:19:40 +0530
Subject: [PATCH] mips: bcm63xx: spi: Fix checkpatch.pl warnings
Message-ID: <1497890980-4334-1-git-send-email-aravind.thk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the checkpatch.pl warnings on the driver
file.

Signed-off-by: Aravind Thokala <aravind.thk@gmail.com>
---
 drivers/spi/spi-bcm63xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 247f71b..84c7356 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -147,7 +147,7 @@ struct bcm63xx_spi {
 
 	/* Platform data */
 	const unsigned long	*reg_offsets;
-	unsigned		fifo_size;
+	unsigned int		fifo_size;
 	unsigned int		msg_type_shift;
 	unsigned int		msg_ctl_width;
 
@@ -191,7 +191,7 @@ static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
 #endif
 }
 
-static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
+static const unsigned int bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
 	{ 20000000, SPI_CLK_20MHZ },
 	{ 12500000, SPI_CLK_12_50MHZ },
 	{  6250000, SPI_CLK_6_250MHZ },
-- 
2.7.4
