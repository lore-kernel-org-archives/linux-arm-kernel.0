From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 26 Jul 2017 14:19:35 +0800
Subject: [PATCH v6 6/7] dt-bindings: display: rockchip: fill Documents for vop
 series
In-Reply-To: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1501049975-6185-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
- clean document commit title
- move changes description out of docummit commit msg

Changes in v2:
- rename rk322x to rk3228
- correct some vop registers define

 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index 9eb3f0a..5d835d9 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -8,8 +8,12 @@ Required properties:
 - compatible: value should be one of the following
 		"rockchip,rk3036-vop";
 		"rockchip,rk3288-vop";
+		"rockchip,rk3368-vop";
+		"rockchip,rk3366-vop";
 		"rockchip,rk3399-vop-big";
 		"rockchip,rk3399-vop-lit";
+		"rockchip,rk3228-vop";
+		"rockchip,rk3328-vop";
 
 - interrupts: should contain a list of all VOP IP block interrupts in the
 		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-- 
1.9.1
