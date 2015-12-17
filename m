From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:45:19 +0800
Subject: [PATCH 6/6] dt-bindings: add document for rk3036-vop
In-Reply-To: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
References: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450323919-32228-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree at vger.kernel.org

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 .../bindings/display/rockchip/rockchip-vop.txt     |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index d15351f..5489b59 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -7,6 +7,7 @@ buffer to an external LCD interface.
 Required properties:
 - compatible: value should be one of the following
 		"rockchip,rk3288-vop";
+		"rockchip,rk3036-vop";
 
 - interrupts: should contain a list of all VOP IP block interrupts in the
 		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
-- 
1.7.9.5
