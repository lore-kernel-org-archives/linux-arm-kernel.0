From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 11 Jul 2017 20:42:38 +0800
Subject: [PATCH 5/5] dt-bindings: display: fill Documents for series of vop
In-Reply-To: <1499776908-16811-1-git-send-email-mark.yao@rock-chips.com>
References: <1499776908-16811-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1499776958-17062-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index 9eb3f0a..11fa3b0 100644
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
+		"rockchip,rk322x-vop";
+		"rockchip,rk3328-vop";
 
 - interrupts: should contain a list of all VOP IP block interrupts in the
 		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-- 
1.9.1
