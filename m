From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 22 Jun 2017 18:29:58 +0800
Subject: [RESEND PATCH v2 3/7] Documentation: rockchip-dw-mshc: add
 description for rk3228
In-Reply-To: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
References: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1498127402-6705-4-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Add "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc" for
dwmmc on rk322x platform.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 18e33cb..a600833 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
 	- "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
 	- "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
+	- "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322x
 	- "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
 	- "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
 	- "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
-- 
2.0.0
