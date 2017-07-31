From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 31 Jul 2017 18:42:08 +0800
Subject: [PATCH v3 2/2] dt-bindings: add documentation for rk3126 clock
In-Reply-To: <1501497728-7805-1-git-send-email-zhangqing@rock-chips.com>
References: <1501497728-7805-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1501497728-7805-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add bindings documentation for rk3126 SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
index 455a9a00a623..25098fa8595f 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt
@@ -1,12 +1,12 @@
-* Rockchip RK3128 Clock and Reset Unit
+* Rockchip RK3128/RK3126 Clock and Reset Unit
 
-The RK3128 clock controller generates and supplies clock to various
+The RK3128/RK3126 clock controller generates and supplies clock to various
 controllers within the SoC and also implements a reset controller for SoC
 peripherals.
 
 Required Properties:
 
-- compatible: should be "rockchip,rk3128-cru"
+- compatible: should be "rockchip,rk3128-cru", "rockchip,rk3126-cru"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - #clock-cells: should be 1.
-- 
1.9.1
