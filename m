From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 27 May 2017 18:23:05 +0800
Subject: [PATCH v3 07/10] dt-bindings: add compatible string for Allwinner R40
 CCU
In-Reply-To: <20170527102308.1988-1-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
Message-ID: <20170527102308.1988-8-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner R40 has a clock controlling unit like the ones on other
Allwinner SoCs after sun6i, and can also use a CCU-based driver.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- Rebased on current linux-next.
- Added Rob's ACK.

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 34b2a9249a94..80926c5db86b 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -9,6 +9,7 @@ Required properties :
 		- "allwinner,sun8i-a83t-ccu"
 		- "allwinner,sun8i-h3-ccu"
 		- "allwinner,sun8i-h3-r-ccu"
+		- "allwinner,sun8i-r40-ccu"
 		- "allwinner,sun8i-v3s-ccu"
 		- "allwinner,sun9i-a80-ccu"
 		- "allwinner,sun50i-a64-ccu"
-- 
2.12.2
