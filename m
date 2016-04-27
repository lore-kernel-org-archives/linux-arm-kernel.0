From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed, 27 Apr 2016 15:54:52 +0800
Subject: [PATCH v4 3/4] Documentation: devicetree: rockchip: Document
 rk3399-evb
In-Reply-To: <1461743693-10671-1-git-send-email-jay.xu@rock-chips.com>
References: <1461743693-10671-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1461743693-10671-4-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "rockchip,rk3399-evb" compatible string for Rockchip RK3399
evaluation board.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes in v4:
- none

changes in v3:
- modify title (Rob)

 Documentation/devicetree/bindings/arm/rockchip.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 2549519..6491b56 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -101,4 +101,8 @@ Rockchip platforms device tree bindings
 
 - Rockchip RK3228 Evaluation board:
     Required root node properties:
-      - compatible = "rockchip,rk3228-evb", "rockchip,rk3228";
+     - compatible = "rockchip,rk3228-evb", "rockchip,rk3228";
+
+- Rockchip RK3399 evb:
+    Required root node properties:
+      - compatible = "rockchip,rk3399-evb", "rockchip,rk3399";
-- 
1.9.1
