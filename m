From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Apr 2016 14:18:14 +0800
Subject: [PATCH v2 2/5] dt-bindings: sort Rockchip vop compatible by chip's
 number
In-Reply-To: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
References: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1461133097-1478-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 .../bindings/display/rockchip/rockchip-vop.txt     |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index 5489b59..196121f 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -6,8 +6,8 @@ buffer to an external LCD interface.
 
 Required properties:
 - compatible: value should be one of the following
-		"rockchip,rk3288-vop";
 		"rockchip,rk3036-vop";
+		"rockchip,rk3288-vop";
 
 - interrupts: should contain a list of all VOP IP block interrupts in the
 		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-- 
1.7.9.5
