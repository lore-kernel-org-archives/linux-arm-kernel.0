From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Mar 2018 01:53:48 +0800
Subject: [PATCH 1/7] dt-bindings: add compatible string for the A64 DE2 CCU
In-Reply-To: <20180316175354.21437-1-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
Message-ID: <20180316175354.21437-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A64 SoC has a DE2 CCU like the one in the DE2 of Allwinner
H5 SoC.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/clock/sun8i-de2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
index f2fa87c4765c..e94582e8b8a9 100644
--- a/Documentation/devicetree/bindings/clock/sun8i-de2.txt
+++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
@@ -6,6 +6,7 @@ Required properties :
 		- "allwinner,sun8i-a83t-de2-clk"
 		- "allwinner,sun8i-h3-de2-clk"
 		- "allwinner,sun8i-v3s-de2-clk"
+		- "allwinner,sun50i-a64-de2-clk"
 		- "allwinner,sun50i-h5-de2-clk"
 
 - reg: Must contain the registers base address and length
-- 
2.15.1
