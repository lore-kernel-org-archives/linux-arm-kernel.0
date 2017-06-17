From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Jun 2017 22:07:35 +0800
Subject: [PATCH 2/4] dt-bindings: syscon: Add DT bindings documentation for
 Allwinner V3s syscon
In-Reply-To: <20170617140737.41951-1-icenowy@aosc.io>
References: <20170617140737.41951-1-icenowy@aosc.io>
Message-ID: <20170617140737.41951-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC has a syscon like the one in H3.

Add its compatible string.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/misc/allwinner,syscon.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/allwinner,syscon.txt b/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
index cb5769137c6c..31494a24fe69 100644
--- a/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
+++ b/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
@@ -9,6 +9,7 @@ Required properties for the system controller:
 - reg: address and length of the register for the device.
 - compatible: should be "syscon" and one of the following string:
 		"allwinner,sun8i-h3-system-controller"
+		"allwinner,sun8i-v3s-system-controller"
 		"allwinner,sun50i-a64-system-controller"
 		"allwinner,sun8i-a83t-system-controller"
 
-- 
2.13.0
