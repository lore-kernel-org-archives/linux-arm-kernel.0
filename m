From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Fri, 22 Apr 2016 13:51:46 +0800
Subject: [PATCH RESEND v2 3/4] ARM64: dts: rockchip: add RK3399 evaluation
 board
In-Reply-To: <1461304307-14113-1-git-send-email-jay.xu@rock-chips.com>
References: <1461304307-14113-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1461304307-14113-4-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RK3399 evaluation board is designed with pmic
rk808 on top board.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes in v2:
- new add patch

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
