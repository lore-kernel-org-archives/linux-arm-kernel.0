From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Apr 2016 14:20:49 +0800
Subject: [PATCH v2 5/5] dt-bindings: add documentation for Rockchip rk3399
 display controllers
In-Reply-To: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
References: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1461133249-1944-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 .../bindings/display/rockchip/rockchip-vop.txt     |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index 196121f..6bf8473 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -8,6 +8,11 @@ Required properties:
 - compatible: value should be one of the following
 		"rockchip,rk3036-vop";
 		"rockchip,rk3288-vop";
+		"rockchip,rk3399-vop-big";
+		"rockchip,rk3399-vop-lit";
+Document compatible values for rk3399 display controllers.
+Big and little display controllers are not identical and have differing
+feature sets on the rk3399.
 
 - interrupts: should contain a list of all VOP IP block interrupts in the
 		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-- 
1.7.9.5
