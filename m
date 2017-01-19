From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Thu, 19 Jan 2017 10:11:58 +0800
Subject: [PATCH 1/2] dt-bindings: add Asus Tinker board
In-Reply-To: <1484791919-4665-1-git-send-email-eddie.cai@rock-chips.com>
References: <1484791919-4665-1-git-send-email-eddie.cai@rock-chips.com>
Message-ID: <1484791919-4665-2-git-send-email-eddie.cai@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tinker board is a credit card size develop board designed by Asus.
Powered by RK3288.

Signed-off-by: Eddie Cai <eddie.cai@rock-chips.com>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6..ce1f04a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -1,5 +1,8 @@
 Rockchip platforms device tree bindings
 ---------------------------------------
+- Asus Tinker board
+    Required root node properties:
+      - compatible = "rockchip,rk3288-tinker", "rockchip,rk3288";
 
 - Kylin RK3036 board:
     Required root node properties:
-- 
2.7.4
