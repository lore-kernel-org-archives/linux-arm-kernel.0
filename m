From: cl@rock-chips.com (cl at rock-chips.com)
Date: Mon, 27 Mar 2017 17:46:23 +0800
Subject: [PATCH v4 6/6] dt-bindings: document rockchip rk3328-evb board
In-Reply-To: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
Message-ID: <1490607983-5599-1-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Use "rockchip,rk3328-evb" compatible string for Rockchip RK3328
evaluation board.

Signed-off-by: Liang Chen <cl@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6..17611cd 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -141,3 +141,7 @@ Rockchip platforms device tree bindings
 - Tronsmart Orion R68 Meta
     Required root node properties:
       - compatible = "tronsmart,orion-r68-meta", "rockchip,rk3368";
+
+- Rockchip RK3328 evb:
+    Required root node properties:
+      - compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
-- 
1.9.1
