From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 17 Nov 2017 16:02:32 +0800
Subject: [PATCH 1/5] dt-bindings: i2c: update documentation for the Meson-AXG
In-Reply-To: <20171117080236.32504-1-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
Message-ID: <20171117080236.32504-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jian Hu <jian.hu@amlogic.com>

Update the doc to explicitly add Meson-AXG to support list

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 611b934c7e10..3097d2b44dad 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -2,6 +2,7 @@ Amlogic Meson I2C controller
 
 Required properties:
  - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
+						"amlogic,meson-axg-i2c"
  - reg: physical address and length of the device registers
  - interrupts: a single interrupt specifier
  - clocks: clock for the device
-- 
2.14.1
