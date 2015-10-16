From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 16 Oct 2015 16:11:41 +0200
Subject: [PATCH] dt-bindings: Correct paths in Rockchip power domains binding
 document
Message-ID: <1445004701-17544-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index 4be34188afe41029..112756e11802c7cc 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -13,7 +13,7 @@ Required properties for power domain controller:
 
 Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
-	"include/dt-bindings/power-domain/rk3288.h" - for RK3288 type power domain.
+	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
 - clocks (optional): phandles to clocks which need to be enabled while power domain
 	switches state.
 
@@ -35,7 +35,7 @@ Node of a device using power domains must have a power-domains property,
 containing a phandle to the power device node and an index specifying which
 power domain to use.
 The index should use macros in:
-	"include/dt-bindings/power-domain/rk3288.h" - for rk3288 type power domain.
+	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
 
 Example of the node using power domain:
 
-- 
1.9.1
