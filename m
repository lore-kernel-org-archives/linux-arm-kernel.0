From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed,  2 Feb 2011 13:50:29 +0100
Subject: [PATCH 1/2] ARM: mxs: adjust flexcan clock definition
In-Reply-To: <1296651030-30792-1-git-send-email-mkl@pengutronix.de>
References: <1296651030-30792-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1296651030-30792-2-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx28.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 2f1a990..c9d7951 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -619,8 +619,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
 	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
 	_REGISTER_CLOCK(NULL, "xclk", xbus_clk)
-	_REGISTER_CLOCK(NULL, "can0", can0_clk)
-	_REGISTER_CLOCK(NULL, "can1", can1_clk)
+	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
+	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
 	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
 	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
-- 
1.7.2.3
