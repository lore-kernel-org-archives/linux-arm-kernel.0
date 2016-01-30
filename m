From: david.wu@rock-chips.com (David Wu)
Date: Sat, 30 Jan 2016 20:20:13 +0800
Subject: [PATCH v4 2/2] dt-bindings: rockchip-pinctrl: Support the RK3399 SoCs
 compatible
In-Reply-To: <1454156413-56148-1-git-send-email-david.wu@rock-chips.com>
References: <1454156413-56148-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1454156413-56148-3-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
Change in v4:
- need Signed-off

 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index 391ef4b..3bb9456 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -22,6 +22,7 @@ Required properties for iomux controller:
   - compatible: one of "rockchip,rk2928-pinctrl", "rockchip,rk3066a-pinctrl"
 		       "rockchip,rk3066b-pinctrl", "rockchip,rk3188-pinctrl"
 		       "rockchip,rk3288-pinctrl", "rockchip,rk3368-pinctrl"
+		       "rockchip,rk3399-pinctrl"
   - rockchip,grf: phandle referencing a syscon providing the
 	 "general register files"
 
-- 
1.9.1
