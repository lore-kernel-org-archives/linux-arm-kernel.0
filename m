From: jay.xu@rock-chips.com (jianqun.xu)
Date: Wed, 17 Feb 2016 09:53:10 +0800
Subject: [PATCH 4/6] pinctrl: rockchip: add bindings for rk3399 pinctrl
In-Reply-To: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1455673992-16469-5-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xu Jianqun <jay.xu@rock-chips.com>

Add devicetree bindings for pinctrl found on rk3399
processors from rockchip.

Signed-off-by: Xu Jianqun <jay.xu@rock-chips.com>
---
 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index 0cd701b..c68b955 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -22,7 +22,7 @@ Required properties for iomux controller:
   - compatible: one of "rockchip,rk2928-pinctrl", "rockchip,rk3066a-pinctrl"
 		       "rockchip,rk3066b-pinctrl", "rockchip,rk3188-pinctrl"
 		       "rockchip,rk3228-pinctrl", "rockchip,rk3288-pinctrl"
-		       "rockchip,rk3368-pinctrl"
+		       "rockchip,rk3368-pinctrl", "rockchip,rk3399-pinctrl"
   - rockchip,grf: phandle referencing a syscon providing the
 	 "general register files"
 
-- 
1.9.1
