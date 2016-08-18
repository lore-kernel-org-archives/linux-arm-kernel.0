From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 18 Aug 2016 14:15:18 -0700
Subject: [PATCH v3 2/5] dt-bindings: sort Rockchip vop compatible by chip's
 number
In-Reply-To: <loom.20160602T085439-162@post.gmane.org>
References: <loom.20160602T085439-162@post.gmane.org>
Message-ID: <1471554918-22353-1-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

Reorder the compatible vop devices to be sorted by chip number
in ascending order.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
[seanpaul added commit description per tfiga's review]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---

Resending to add devicetree list

Changes in v3:
	- Updated commit message (Tomasz Figa)

 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 2 +-
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
2.8.0.rc3.226.g39d4020
