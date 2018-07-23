From: cl@rock-chips.com (cl at rock-chips.com)
Date: Mon, 23 Jul 2018 17:25:21 +0800
Subject: [PATCH v2 3/6] dt-bindings: sound: rockchip-i2s: add description for
 px30
In-Reply-To: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
References: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
Message-ID: <1532337924-4185-4-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Add "rockchip,px30-i2s", "rockchip,rk3066-i2s" for i2s on px30 platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index b208a75..54aefab 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -7,6 +7,7 @@ Required properties:
 
 - compatible: should be one of the following:
    - "rockchip,rk3066-i2s": for rk3066
+   - "rockchip,px30-i2s", "rockchip,rk3066-i2s": for px30
    - "rockchip,rk3036-i2s", "rockchip,rk3066-i2s": for rk3036
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
    - "rockchip,rk3228-i2s", "rockchip,rk3066-i2s": for rk3228
-- 
1.9.1
