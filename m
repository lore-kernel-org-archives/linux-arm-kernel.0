From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  8 Jul 2016 17:04:57 +0800
Subject: [PATCH 3/7] dt-bindings: add power domain node for dw-mipi-rockchip
In-Reply-To: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
References: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1467968701-15620-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 4d59df3..e433ba5 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -17,6 +17,7 @@ Required properties:
 Optional properties:
 - clocks, clock-names: phandle to the dw-mipi phy clock, name should be
 		       "phy_cfg".
+- power-domains: a phandle to mipi dsi power domain node.
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/media/video-interfaces.txt
-- 
2.6.3
