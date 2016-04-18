From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 18 Apr 2016 11:17:58 +0800
Subject: [PATCH 2/2] dt-bindings: add document for rk3399-vop
In-Reply-To: <1460949478-2236-1-git-send-email-mark.yao@rock-chips.com>
References: <1460949478-2236-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1460949478-2236-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 .../bindings/display/rockchip/rockchip-vop.txt     |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index 5489b59..fd25ea9 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -8,6 +8,8 @@ Required properties:
 - compatible: value should be one of the following
 		"rockchip,rk3288-vop";
 		"rockchip,rk3036-vop";
+		"rockchip,rk3399-vop-big";
+		"rockchip,rk3399-vop-lit";
 
 - interrupts: should contain a list of all VOP IP block interrupts in the
 		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-- 
1.7.9.5
