From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 20 Jan 2017 18:10:50 +0800
Subject: [PATCH v3 4/5] dt-bindings: add power domain node for dw-mipi-rockchip
In-Reply-To: <1484907051-7159-1-git-send-email-zyw@rock-chips.com>
References: <1484907051-7159-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484907051-7159-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None

 .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 0f82568..188f6f7 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -15,6 +15,9 @@ Required properties:
 - ports: contain a port node with endpoint definitions as defined in [2].
   For vopb,set the reg = <0> and set the reg = <1> for vopl.
 
+Optional properties:
+- power-domains: a phandle to mipi dsi power domain node.
+
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/media/video-interfaces.txt
 
-- 
2.6.3
