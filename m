From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 14:58:28 +0800
Subject: [PATCH v6 2/3] ARM: imx6q: clk_register_clkdev usbmisc clock
In-Reply-To: <1346137109-32247-1-git-send-email-richard.zhao@freescale.com>
References: <1346137109-32247-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137109-32247-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index ea89520..660fcbb 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -405,6 +405,7 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[usboh3], NULL, "2184200.usb");
 	clk_register_clkdev(clk[usboh3], NULL, "2184400.usb");
 	clk_register_clkdev(clk[usboh3], NULL, "2184600.usb");
+	clk_register_clkdev(clk[usboh3], NULL, "2184800.usbmisc");
 	clk_register_clkdev(clk[usbphy1], NULL, "20c9000.usbphy");
 	clk_register_clkdev(clk[usbphy2], NULL, "20ca000.usbphy");
 	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
-- 
1.7.9.5
