From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 23 Nov 2012 10:09:03 +0100
Subject: [PATCH 2/3] i2c: at91: change struct members indentation
In-Reply-To: <1353661744-5703-1-git-send-email-ludovic.desroches@atmel.com>
References: <1353661744-5703-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1353661744-5703-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Replace tabs for struct members indentation by space to minimise line changes
when adding new members which would require extra tabs to keep alignment.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index f222600..f82649b 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -65,24 +65,24 @@
 #define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
 
 struct at91_twi_pdata {
-	unsigned	clk_max_div;
-	unsigned	clk_offset;
-	bool		has_unre_flag;
+	unsigned clk_max_div;
+	unsigned clk_offset;
+	bool has_unre_flag;
 };
 
 struct at91_twi_dev {
-	struct device		*dev;
-	void __iomem		*base;
-	struct completion	cmd_complete;
-	struct clk		*clk;
-	u8			*buf;
-	size_t			buf_len;
-	struct i2c_msg		*msg;
-	int			irq;
-	unsigned		transfer_status;
-	struct i2c_adapter	adapter;
-	unsigned		twi_cwgr_reg;
-	struct at91_twi_pdata	*pdata;
+	struct device *dev;
+	void __iomem *base;
+	struct completion cmd_complete;
+	struct clk *clk;
+	u8 *buf;
+	size_t buf_len;
+	struct i2c_msg *msg;
+	int irq;
+	unsigned transfer_status;
+	struct i2c_adapter adapter;
+	unsigned twi_cwgr_reg;
+	struct at91_twi_pdata *pdata;
 };
 
 static unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg)
-- 
1.7.11.3
