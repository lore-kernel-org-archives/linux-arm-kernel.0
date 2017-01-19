From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 20 Jan 2017 01:54:46 +0800
Subject: [PATCH v3 4/6] dt-bindings: add device binding for the CCU of
 Allwinner V3s
In-Reply-To: <20170119175448.11445-1-icenowy@aosc.xyz>
References: <20170119175448.11445-1-icenowy@aosc.xyz>
Message-ID: <20170119175448.11445-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s is now driven by sunxi-ng CCU driver.

Add devicetree binding for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 74d44a4273f2..f6032cf63f12 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -7,6 +7,7 @@ Required properties :
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
 		- "allwinner,sun8i-h3-ccu"
+		- "allwinner,sun8i-v3s-ccu"
 		- "allwinner,sun50i-a64-ccu"
 
 - reg: Must contain the registers base address and length
-- 
2.11.0
