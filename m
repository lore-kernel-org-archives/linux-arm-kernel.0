From: hjc@rock-chips.com (Sandy Huang)
Date: Tue, 14 Nov 2017 19:27:34 +0800
Subject: [PATCH 1/2] dt-bindings: add document for rk3126-vop
In-Reply-To: <1510658851-90160-1-git-send-email-hjc@rock-chips.com>
References: <1510658851-90160-1-git-send-email-hjc@rock-chips.com>
Message-ID: <1510658855-90223-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index 5d835d9..eeda359 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -7,6 +7,7 @@ buffer to an external LCD interface.
 Required properties:
 - compatible: value should be one of the following
 		"rockchip,rk3036-vop";
+		"rockchip,rk3126-vop";
 		"rockchip,rk3288-vop";
 		"rockchip,rk3368-vop";
 		"rockchip,rk3366-vop";
-- 
2.7.4
