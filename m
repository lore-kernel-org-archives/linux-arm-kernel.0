From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Fri, 22 Apr 2016 13:25:29 +0800
Subject: [PATCH v2 1/4] Documentation: rockchip-dw-mshc: add description for
 rk3399
In-Reply-To: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1461302729-13419-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Add "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc" for
dwmmc on rk3399 platform.

Change-Id: Ieefafab5f0e9650271e823659e2bec1556c4a9bc
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index ea5614b..07184e8 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
 	- "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
 	- "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
+	- "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
 
 Optional Properties:
 * clocks: from common clock binding: if ciu_drive and ciu_sample are
-- 
1.9.1
