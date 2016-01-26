From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 26 Jan 2016 10:34:14 +0800
Subject: [PATCH] Documentation: rockchip-dw-mshc: add RK3036 dw-mshc
 description
Message-ID: <1453775654-16105-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3036 dtsi file add dw-mshc compatible "rockchip,rk3036-dw-mshc"
but didn't add it into rockchip-dw-mshc.txt.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 634e249..ea5614b 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "rockchip,rk2928-dw-mshc": for Rockchip RK2928 and following,
 							before RK3288
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
+	- "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
 	- "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
 
 Optional Properties:
-- 
2.3.7
