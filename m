From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  1 Mar 2017 12:15:39 +0800
Subject: [PATCH 1/3] dt-bindings: update device tree binding for Allwinner
 PRCM CCUs
In-Reply-To: <20170301041541.24388-1-icenowy@aosc.xyz>
References: <20170301041541.24388-1-icenowy@aosc.xyz>
Message-ID: <20170301041541.24388-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Allwinner SoCs after A31 have a CCU in PRCM block.

Give the ones on H3 and A64 compatible strings.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index bae5668cf427..c774d55740f5 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -7,9 +7,11 @@ Required properties :
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
 		- "allwinner,sun8i-h3-ccu"
+		- "allwinner,sun8i-h3-r-ccu"
 		- "allwinner,sun8i-v3s-ccu"
 		- "allwinner,sun9i-a80-ccu"
 		- "allwinner,sun50i-a64-ccu"
+		- "allwinner,sun50i-a64-r-ccu"
 
 - reg: Must contain the registers base address and length
 - clocks: phandle to the oscillators feeding the CCU. Two are needed:
-- 
2.11.1
