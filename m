From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Wed, 23 May 2018 14:50:48 +0800
Subject: [PATCH v3 06/13] dt-bindings: add binding for rk3128 power domains
In-Reply-To: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1527058248-10366-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the power domains
found on Rockchip RK3128 SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index 79924ee9ae86..9a3f5fd36a80 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -6,6 +6,7 @@ powered up/down by software based on different application scenes to save power.
 Required properties for power domain controller:
 - compatible: Should be one of the following.
 	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
+	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
 	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
 	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
 	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
@@ -19,6 +20,7 @@ Required properties for power domain controller:
 Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
 	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
+	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
 	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
 	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
@@ -96,6 +98,7 @@ containing a phandle to the power device node and an index specifying which
 power domain to use.
 The index should use macros in:
 	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
+	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
 	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
 	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
-- 
1.9.1
