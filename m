From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri,  9 May 2014 13:11:50 +0200
Subject: [PATCH v3 6/7] clk: sunxi: document PRCM clock compatible strings
In-Reply-To: <1399633911-7094-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1399633911-7094-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1399633911-7094-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document new compatible strings for clock provided by the PRCM
(Power/Reset/Clock Management) unit.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index a5160d8..d154d9d 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -20,12 +20,16 @@ Required properties:
 	"allwinner,sun5i-a13-ahb-gates-clk" - for the AHB gates on A13
 	"allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
 	"allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
+	"allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
+	"allwinner,sun6i-a31-ahb0-clk" - for the AHB0 multiplexer on A31
 	"allwinner,sun6i-a31-ahb1-mux-clk" - for the AHB1 multiplexer on A31
 	"allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
 	"allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
+	"allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
 	"allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
 	"allwinner,sun5i-a13-apb0-gates-clk" - for the APB0 gates on A13
 	"allwinner,sun5i-a10s-apb0-gates-clk" - for the APB0 gates on A10s
+	"allwinner,sun6i-a31-apb0-gates-clk" - for the APB0 gates on A31
 	"allwinner,sun7i-a20-apb0-gates-clk" - for the APB0 gates on A20
 	"allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
 	"allwinner,sun4i-a10-apb1-mux-clk" - for the APB1 clock muxing
-- 
1.8.3.2
