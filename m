From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 16 Jan 2014 09:06:24 +0100
Subject: [PATCHv2 1/2] pwm: imx: indentation cleanup
In-Reply-To: <1389859585-14006-1-git-send-email-LW@KARO-electronics.de>
References: <1389859585-14006-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1389859585-14006-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consistently use TABs for indentation and the same indentation level.
No functional change.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/pwm/pwm-imx.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cc47733..3b00a82 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -21,24 +21,24 @@
 
 /* i.MX1 and i.MX21 share the same PWM function block: */
 
-#define MX1_PWMC    0x00   /* PWM Control Register */
-#define MX1_PWMS    0x04   /* PWM Sample Register */
-#define MX1_PWMP    0x08   /* PWM Period Register */
+#define MX1_PWMC			0x00   /* PWM Control Register */
+#define MX1_PWMS			0x04   /* PWM Sample Register */
+#define MX1_PWMP			0x08   /* PWM Period Register */
 
-#define MX1_PWMC_EN		(1 << 4)
+#define MX1_PWMC_EN			(1 << 4)
 
 /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
 
-#define MX3_PWMCR                 0x00    /* PWM Control Register */
-#define MX3_PWMSAR                0x0C    /* PWM Sample Register */
-#define MX3_PWMPR                 0x10    /* PWM Period Register */
-#define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
-#define MX3_PWMCR_DOZEEN                (1 << 24)
-#define MX3_PWMCR_WAITEN                (1 << 23)
+#define MX3_PWMCR			0x00   /* PWM Control Register */
+#define MX3_PWMSAR			0x0C   /* PWM Sample Register */
+#define MX3_PWMPR			0x10   /* PWM Period Register */
+#define MX3_PWMCR_PRESCALER(x)		(((x - 1) & 0xFFF) << 4)
+#define MX3_PWMCR_DOZEEN		(1 << 24)
+#define MX3_PWMCR_WAITEN		(1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
-#define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
-#define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
-#define MX3_PWMCR_EN              (1 << 0)
+#define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
+#define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
+#define MX3_PWMCR_EN			(1 << 0)
 
 struct imx_chip {
 	struct clk	*clk_per;
-- 
1.7.2.5
