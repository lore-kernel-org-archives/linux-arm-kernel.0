From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Mar 2017 18:18:35 +0100
Subject: [PATCH v2 1/6] dt-bindings: rockchip, pinctrl: rename RK1108 to RV1108
In-Reply-To: <20170317171840.4683-1-heiko@sntech.de>
References: <20170317171840.4683-1-heiko@sntech.de>
Message-ID: <20170317171840.4683-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Yan <andy.yan@rock-chips.com>

Rockchip finally named the SOC as RV1108, so change it.
Also move the compatible list to one compatible per line.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/pinctrl/rockchip,pinctrl.txt    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index 403b5a272f56..ee01ab58224d 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -19,11 +19,18 @@ The pins are grouped into up to 5 individual pin banks which need to be
 defined as gpio sub-nodes of the pinmux controller.
 
 Required properties for iomux controller:
-  - compatible: one of "rockchip,rk1108-pinctrl", "rockchip,rk2928-pinctrl"
-		       "rockchip,rk3066a-pinctrl", "rockchip,rk3066b-pinctrl"
-		       "rockchip,rk3188-pinctrl", "rockchip,rk3228-pinctrl"
-		       "rockchip,rk3288-pinctrl", "rockchip,rk3328-pinctrl"
-		       "rockchip,rk3368-pinctrl", "rockchip,rk3399-pinctrl"
+  - compatible: should be
+		"rockchip,rv1108-pinctrl":  for Rockchip RV1108
+		"rockchip,rk2928-pinctrl":  for Rockchip RK2928
+		"rockchip,rk3066a-pinctrl": for Rockchip RK3066a
+		"rockchip,rk3066b-pinctrl": for Rockchip RK3066b
+		"rockchip,rk3188-pinctrl":  for Rockchip RK3188
+		"rockchip,rk3228-pinctrl":  for Rockchip RK3228
+		"rockchip,rk3288-pinctrl":  for Rockchip RK3288
+		"rockchip,rk3328-pinctrl":  for Rockchip RK3328
+		"rockchip,rk3368-pinctrl":  for Rockchip RK3368
+		"rockchip,rk3399-pinctrl":  for Rockchip RK3399
+
   - rockchip,grf: phandle referencing a syscon providing the
 	 "general register files"
 
-- 
2.11.0
