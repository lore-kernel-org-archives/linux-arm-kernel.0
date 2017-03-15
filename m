From: cl@rock-chips.com (cl at rock-chips.com)
Date: Wed, 15 Mar 2017 18:03:53 +0800
Subject: [PATCH v1 3/7] dt-bindings: i2c: rk3x: add support for rk3328
In-Reply-To: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
Message-ID: <1489572237-6649-4-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Liang <cl@rock-chips.com>

The rk3328 i2c is the same as rk3399

Signed-off-by: Chen Liang <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index bbc5a1e..abfdefd 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -12,6 +12,7 @@ Required properties :
    - "rockchip,rk3228-i2c": for rk3228
    - "rockchip,rk3288-i2c": for rk3288
    - "rockchip,rk3399-i2c": for rk3399
+   - "rockchip,rk3328-i2c", "rockchip,rk3399-i2c": for rk3328
  - interrupts : interrupt number
  - clocks: See ../clock/clock-bindings.txt
    - For older hardware (rk3066, rk3188, rk3228, rk3288):
-- 
1.9.1
