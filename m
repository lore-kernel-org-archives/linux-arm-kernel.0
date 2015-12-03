From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Dec 2015 16:20:11 +0800
Subject: [PATCH 2/4] irqchip/sunxi-nmi: Add sun9i-a80 variant to binding doc
In-Reply-To: <1449130813-22400-1-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
Message-ID: <1449130813-22400-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun9i A80 introduces a new variant of the NMI controller. The registers
are reordered, but the functionality remains the same.

Add a new compatible string for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
index d1c5cdabc3e0..81cd3692405e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
@@ -4,7 +4,7 @@ Allwinner Sunxi NMI Controller
 Required properties:
 
 - compatible : should be "allwinner,sun7i-a20-sc-nmi" or
-  "allwinner,sun6i-a31-sc-nmi"
+  "allwinner,sun6i-a31-sc-nmi" or "allwinner,sun9i-a80-nmi"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.6.2
