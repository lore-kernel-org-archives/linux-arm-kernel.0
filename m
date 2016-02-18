From: k@japko.eu (Krzysztof Adamski)
Date: Thu, 18 Feb 2016 20:49:31 +0100
Subject: [PATCH] pinctrl: sunxi: Add missing H3 R_PIO binding documentation
In-Reply-To: <CACRpkdbfNeh7_=3ReQtJc7OxkkQEn+BUhZ0O0SKnFsRD=WZiUQ@mail.gmail.com>
References: <CACRpkdbfNeh7_=3ReQtJc7OxkkQEn+BUhZ0O0SKnFsRD=WZiUQ@mail.gmail.com>
Message-ID: <20160218194931.GA16393@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

allwinner,sun8i-h3-r-pinctrl was added by
commit ba83a11104ae ("pinctrl: sunxi: Add H3 R_PIO controller support")
but the patch was missing proper binding documentation. This patch fixes
this issue.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 9213b27..3e56b16 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -21,6 +21,7 @@ Required properties:
   "allwinner,sun9i-a80-r-pinctrl"
   "allwinner,sun8i-a83t-pinctrl"
   "allwinner,sun8i-h3-pinctrl"
+  "allwinner,sun8i-h3-r-pinctrl"
 
 - reg: Should contain the register physical address and length for the
   pin controller.
-- 
2.1.4
