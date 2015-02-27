From: andy.yan@rock-chips.com (Andy Yan)
Date: Fri, 27 Feb 2015 18:59:01 +0800
Subject: [PATCH 1/2] dt-bindings: add root compatible property for PopMetal
 board
In-Reply-To: <1425034505-25163-1-git-send-email-andy.yan@rock-chips.com>
References: <1425034505-25163-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1425034741-25229-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PopMetal board is a rk3288 based board made by ChipSpark,
this patch add root compatible property for it

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 6809e4e..818d249 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -22,3 +22,7 @@ Rockchip platforms device tree bindings
       - compatible = "firefly,firefly-rk3288", "rockchip,rk3288";
     or
       - compatible = "firefly,firefly-rk3288-beta", "rockchip,rk3288";
+
+- PopMetal PopMetal-RK3288 board:
+    Required root node properties:
+      - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
-- 
1.9.1
