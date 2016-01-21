From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 21 Jan 2016 20:32:09 +0800
Subject: [PATCH] Documentation: rockchip-dw-mshc: add RK3368 dw-mshc
 description
Message-ID: <1453379529-5148-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3368 dtsi file add dw-mshc compatible "rockchip,rk3368-dw-mshc"
but didn't add it into rockchip-dw-mshc.txt.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 3dc13b6..634e249 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "rockchip,rk2928-dw-mshc": for Rockchip RK2928 and following,
 							before RK3288
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
+	- "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
 
 Optional Properties:
 * clocks: from common clock binding: if ciu_drive and ciu_sample are
-- 
2.3.7
