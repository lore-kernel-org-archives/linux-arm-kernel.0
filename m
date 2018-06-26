From: hjc@rock-chips.com (Sandy Huang)
Date: Tue, 26 Jun 2018 16:53:34 +0800
Subject: [PATCH 1/2] dt-bindings: display: rockchip: add document for px30 vop
In-Reply-To: <1530003215-46593-1-git-send-email-hjc@rock-chips.com>
References: <1530003215-46593-1-git-send-email-hjc@rock-chips.com>
Message-ID: <1530003215-46593-2-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index eeda359..5de2a0f 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -8,6 +8,8 @@ Required properties:
 - compatible: value should be one of the following
 		"rockchip,rk3036-vop";
 		"rockchip,rk3126-vop";
+		"rockchip,px30-vop-lit";
+		"rockchip,px30-vop-big";
 		"rockchip,rk3288-vop";
 		"rockchip,rk3368-vop";
 		"rockchip,rk3366-vop";
-- 
2.7.4
