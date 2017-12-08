From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 8 Dec 2017 09:54:17 +0800
Subject: [PATCH v4 1/2] documentation: Add compatibles for Amlogic Meson AXG
 pin controllers
In-Reply-To: <20171208015418.9632-1-yixun.lan@amlogic.com>
References: <20171208015418.9632-1-yixun.lan@amlogic.com>
Message-ID: <20171208015418.9632-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Add compatibles for Amlogic Meson AXG pin controllers

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 2392557ede27..2c12f9789116 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -9,6 +9,8 @@ Required properties for the root node:
 		      "amlogic,meson-gxbb-aobus-pinctrl"
 		      "amlogic,meson-gxl-periphs-pinctrl"
 		      "amlogic,meson-gxl-aobus-pinctrl"
+		      "amlogic,meson-axg-periphs-pinctrl"
+		      "amlogic,meson-axg-aobus-pinctrl"
  - reg: address and size of registers controlling irq functionality
 
 === GPIO sub-nodes ===
-- 
2.15.1
