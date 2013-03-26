From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 26 Mar 2013 23:07:16 +0100
Subject: [PATCH v6 2/7] irqchip: s3c24xx: fix comments on some camera
 interrupts
In-Reply-To: <201303262305.49725.heiko@sntech.de>
References: <201303262305.49725.heiko@sntech.de>
Message-ID: <201303262307.16809.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Might be confusing for people to read the code without having the
datasheet nearby.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/irqchip/irq-s3c24xx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 5c9f8b7..84afbc1 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -916,8 +916,8 @@ static struct s3c_irq_data init_s3c2440subint[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-ERR */
 	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* TC */
 	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* ADC */
-	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* TC */
-	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* ADC */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_C */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_P */
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* WDT */
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* AC97 */
 };
@@ -991,8 +991,8 @@ static struct s3c_irq_data init_s3c2442subint[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-ERR */
 	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* TC */
 	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* ADC */
-	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* TC */
-	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* ADC */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_C */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_P */
 };
 
 void __init s3c2442_init_irq(void)
-- 
1.7.10.4
