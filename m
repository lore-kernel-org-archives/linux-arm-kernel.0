From: cl@rock-chips.com (cl at rock-chips.com)
Date: Thu, 16 Mar 2017 21:23:06 +0800
Subject: [PATCH v2 6/6] dt-bindings: document rockchip rk3328-evb board
In-Reply-To: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
Message-ID: <1489670586-16120-1-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Use "rockchip,rk3328-evb" compatible string for Rockchip RK3328
evaluation board.

Signed-off-by: Liang Chen <cl@rock-chips.com>
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
