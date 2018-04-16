From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 16 Apr 2018 17:40:20 +0200
Subject: [PATCH 5/6] spi: spi-s3c64xx: Fix indentation in the register
 offset definitions
In-Reply-To: <20180416154021.25626-1-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154158epcas2p3120ff2617db98504c4e48d5cc4c42036@epcas2p3.samsung.com>
Message-ID: <20180416154021.25626-5-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change indentation so register address offset and register bit definitions
are aligned to same column.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d87fa7d9fad3..2723fa6bed8b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -28,15 +28,15 @@

 #define S3C64XX_SPI_CH_CFG		0x00
 #define S3C64XX_SPI_CLK_CFG		0x04
-#define S3C64XX_SPI_MODE_CFG	0x08
-#define S3C64XX_SPI_SLAVE_SEL	0x0C
+#define S3C64XX_SPI_MODE_CFG		0x08
+#define S3C64XX_SPI_SLAVE_SEL		0x0C
 #define S3C64XX_SPI_INT_EN		0x10
 #define S3C64XX_SPI_STATUS		0x14
 #define S3C64XX_SPI_TX_DATA		0x18
 #define S3C64XX_SPI_RX_DATA		0x1C
-#define S3C64XX_SPI_PACKET_CNT	0x20
-#define S3C64XX_SPI_PENDING_CLR	0x24
-#define S3C64XX_SPI_SWAP_CFG	0x28
+#define S3C64XX_SPI_PACKET_CNT		0x20
+#define S3C64XX_SPI_PENDING_CLR		0x24
+#define S3C64XX_SPI_SWAP_CFG		0x28
 #define S3C64XX_SPI_FB_CLK		0x2C

 #define S3C64XX_SPI_CH_HS_EN		(1<<6)	/* High Speed Enable */
@@ -77,9 +77,9 @@
 #define S3C64XX_SPI_INT_TX_FIFORDY_EN		(1<<0)

 #define S3C64XX_SPI_ST_RX_OVERRUN_ERR		(1<<5)
-#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR	(1<<4)
+#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		(1<<4)
 #define S3C64XX_SPI_ST_TX_OVERRUN_ERR		(1<<3)
-#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR	(1<<2)
+#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR		(1<<2)
 #define S3C64XX_SPI_ST_RX_FIFORDY		(1<<1)
 #define S3C64XX_SPI_ST_TX_FIFORDY		(1<<0)

@@ -100,7 +100,7 @@
 #define S3C64XX_SPI_SWAP_TX_BIT			(1<<1)
 #define S3C64XX_SPI_SWAP_TX_EN			(1<<0)

-#define S3C64XX_SPI_FBCLK_MSK		(3<<0)
+#define S3C64XX_SPI_FBCLK_MSK			(3<<0)

 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
--
2.14.2
