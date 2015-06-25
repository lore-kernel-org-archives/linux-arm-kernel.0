From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 25 Jun 2015 20:15:12 +0200
Subject: [PATCH 4/4] dt-bindings: document rk3368 R89 board from Rockchip
In-Reply-To: <1650408.ovnAjReNFJ@diego>
References: <1650408.ovnAjReNFJ@diego>
Message-ID: <1656103.SqN7hZrCiS@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial board containing the rk3368 ARM64 soc.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This should probably be simply in one branch with the Netxeon board
seen in the diff above, to prevent unncessary merge conflicts?

 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index b30bed1..c4119e0 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -30,3 +30,7 @@ Rockchip platforms device tree bindings
 - Netxeon R89 board:
     Required root node properties:
       - compatible = "netxeon,r89", "rockchip,rk3288";
+
+- Rockchip R88 board:
+    Required root node properties:
+      - compatible = "rockchip,r88", "rockchip,rk3368";
-- 
2.1.4
