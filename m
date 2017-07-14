From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 14 Jul 2017 15:02:42 +0800
Subject: [PATCH v1 2/3] dt-bindings: add binding for rk3366 power domains
In-Reply-To: <1500015763-4940-1-git-send-email-zhangqing@rock-chips.com>
References: <1500015763-4940-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1500015763-4940-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the power domains
found on Rockchip RK3366 SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index 01bfb6745fbd..301d2a9bc1b8 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -7,6 +7,7 @@ Required properties for power domain controller:
 - compatible: Should be one of the following.
 	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
 	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
+	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
 	"rockchip,rk3368-power-controller" - for RK3368 SoCs.
 	"rockchip,rk3399-power-controller" - for RK3399 SoCs.
 - #power-domain-cells: Number of cells in a power-domain specifier.
@@ -18,6 +19,7 @@ Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
 	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
+	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
 	"include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
 	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
 - clocks (optional): phandles to clocks which need to be enabled while power domain
@@ -93,6 +95,7 @@ power domain to use.
 The index should use macros in:
 	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
+	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
 	"include/dt-bindings/power/rk3368-power.h" - for rk3368 type power domain.
 	"include/dt-bindings/power/rk3399-power.h" - for rk3399 type power domain.
 
-- 
1.9.1
