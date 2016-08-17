From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 17 Aug 2016 10:16:42 -0700
Subject: [PATCH v3 5/5] dt-bindings: add compatible strings for big/little
 rockchip vops
In-Reply-To: <loom.20160602T092953-610@post.gmane.org>
References: <loom.20160602T092953-610@post.gmane.org>
Message-ID: <1471454202-1631-1-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

This patch documents the compatible strings for the big and little vop
in rockchip's drm driver.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
[seanpaul removed superfluous description per tfiga's review]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v3:
	- Updated subject (Sean Paul)
	- Removed unnecessary description (Tomasz)

 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index 196121f..9eb3f0a 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -8,6 +8,8 @@ Required properties:
 - compatible: value should be one of the following
 		"rockchip,rk3036-vop";
 		"rockchip,rk3288-vop";
+		"rockchip,rk3399-vop-big";
+		"rockchip,rk3399-vop-lit";
 
 - interrupts: should contain a list of all VOP IP block interrupts in the
 		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-- 
2.8.0.rc3.226.g39d4020
