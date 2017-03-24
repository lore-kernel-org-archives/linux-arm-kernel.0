From: cl@rock-chips.com (cl at rock-chips.com)
Date: Fri, 24 Mar 2017 19:01:23 +0800
Subject: [PATCH v3 2/6] dt-bindings: i2c: rk3x: add support for rk3328
In-Reply-To: <1490353287-25122-1-git-send-email-cl@rock-chips.com>
References: <1490353287-25122-1-git-send-email-cl@rock-chips.com>
Message-ID: <1490353287-25122-3-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

The rk3328 i2c is the same as rk3399

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index bbc5a1e..e18445d 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -11,6 +11,7 @@ Required properties :
    - "rockchip,rk3188-i2c": for rk3188
    - "rockchip,rk3228-i2c": for rk3228
    - "rockchip,rk3288-i2c": for rk3288
+   - "rockchip,rk3328-i2c", "rockchip,rk3399-i2c": for rk3328
    - "rockchip,rk3399-i2c": for rk3399
  - interrupts : interrupt number
  - clocks: See ../clock/clock-bindings.txt
-- 
1.9.1
