From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 16 Mar 2017 11:31:45 +0800
Subject: [PATCH v2 2/4] dt-bindings: add the grf clock for dw-mipi-dsi
In-Reply-To: <1489635107-21327-1-git-send-email-zyw@rock-chips.com>
References: <1489635107-21327-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1489635107-21327-3-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For RK3399, the grf clock should be controlled by dw-mipi-dsi driver,
add the description for this clock.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v2: None

 .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 188f6f7..7e17a60 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -10,7 +10,7 @@ Required properties:
 - interrupts: Represent the controller's interrupt to the CPU(s).
 - clocks, clock-names: Phandles to the controller's pll reference
   clock(ref) and APB clock(pclk). For RK3399, a phy config clock
-  (phy_cfg) is additional required. As described in [1].
+  (phy_cfg) and a grf clock(grf) are additional required. As described in [1].
 - rockchip,grf: this soc should set GRF regs to mux vopl/vopb.
 - ports: contain a port node with endpoint definitions as defined in [2].
   For vopb,set the reg = <0> and set the reg = <1> for vopl.
-- 
2.6.3
