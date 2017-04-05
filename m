From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed,  5 Apr 2017 17:33:20 +0800
Subject: [PATCH v2 2/2] dt-bindings: document: add firefly-rk3399 board support
In-Reply-To: <1491384800-22412-1-git-send-email-kever.yang@rock-chips.com>
References: <1491384800-22412-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1491384800-22412-2-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "firefly,firefly-rk3399" compatible string for firefly-rk3399 board.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 250fdf0..b5201f4 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -42,6 +42,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "firefly,firefly-rk3288-reload", "rockchip,rk3288";
 
+- Firefly Firefly-RK3399 board:
+    Required root node properties:
+      - compatible = "firefly,firefly-rk3399", "rockchip,rk3399";
+
 - ChipSPARK PopMetal-RK3288 board:
     Required root node properties:
       - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
-- 
1.9.1
