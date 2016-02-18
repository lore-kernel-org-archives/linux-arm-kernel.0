From: krzysztof.adamski@tieto.com (Krzysztof Adamski)
Date: Thu, 18 Feb 2016 16:03:29 +0100
Subject: [PATCH] clk: sunxi: Add missing H3 apb0 clock documentation
In-Reply-To: <CACRpkdbfNeh7_=3ReQtJc7OxkkQEn+BUhZ0O0SKnFsRD=WZiUQ@mail.gmail.com>
References: <CACRpkdbfNeh7_=3ReQtJc7OxkkQEn+BUhZ0O0SKnFsRD=WZiUQ@mail.gmail.com>
Message-ID: <1455807809-30827-1-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

allwinner,sun8i-h3-apb0-gates-clk was added by
commit ba83a11104ae ("pinctrl: sunxi: Add H3 R_PIO controller support")
but the patch was missing proper binding documentation. This patch fixes
this issue.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index c09f59b..37d0fd6 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -38,6 +38,7 @@ Required properties:
 	"allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
 	"allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
 	"allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
+	"allwinner,sun8i-h3-apb0-gates-clk" - for the APB0 gates on H3
 	"allwinner,sun9i-a80-apb0-clk" - for the APB0 bus clock on A80
 	"allwinner,sun8i-a83t-apb0-gates-clk" - for the APB0 gates on A83T
 	"allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
-- 
2.1.4
