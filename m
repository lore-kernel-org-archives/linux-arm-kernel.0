From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 May 2018 03:14:19 +0800
Subject: [PATCH RESEND net-next v2 2/8] dt-bindings: net: dwmac-sun8i: Sort
 syscon compatibles by alphabetical order
In-Reply-To: <20180513191425.9801-1-wens@csie.org>
References: <20180513191425.9801-1-wens@csie.org>
Message-ID: <20180513191425.9801-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T syscon compatible was appended to the syscon compatibles list,
instead of inserted in to preserve the ordering.

Move it to the proper place to keep the list sorted.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index e04ce75e24a3..1b8e33e71651 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -22,10 +22,10 @@ Required properties:
 - #size-cells: shall be 0
 - syscon: A phandle to the syscon of the SoC with one of the following
  compatible string:
+  - allwinner,sun8i-a83t-system-controller
   - allwinner,sun8i-h3-system-controller
   - allwinner,sun8i-v3s-system-controller
   - allwinner,sun50i-a64-system-controller
-  - allwinner,sun8i-a83t-system-controller
 
 Optional properties:
 - allwinner,tx-delay-ps: TX clock delay chain value in ps.
-- 
2.17.0
