From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 20 Nov 2017 22:54:11 +0800
Subject: [PATCH v2 1/5] dt-bindings: i2c: update documentation for the
 Meson-AXG
In-Reply-To: <20171120145415.6581-1-yixun.lan@amlogic.com>
References: <20171120145415.6581-1-yixun.lan@amlogic.com>
Message-ID: <20171120145415.6581-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jian Hu <jian.hu@amlogic.com>

Update the doc to explicitly add Meson-AXG to support list

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 611b934c7e10..13d410de077c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -1,7 +1,11 @@
 Amlogic Meson I2C controller
 
 Required properties:
- - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
+ - compatible: must be:
+	"amlogic,meson6-i2c" for Meson8 and compatible SoCs
+	"amlogic,meson-gxbb-i2c" for GXBB and compatible SoCs
+	"amlogic,meson-axg-i2c"for AXG and compatible SoCs
+
  - reg: physical address and length of the device registers
  - interrupts: a single interrupt specifier
  - clocks: clock for the device
-- 
2.15.0
