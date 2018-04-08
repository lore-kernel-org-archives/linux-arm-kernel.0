From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sun, 8 Apr 2018 14:56:59 +0000
Subject: [PATCH 2/3] dt-bindings: interrupt-controller: New binding for
 Meson-AXG SoC
In-Reply-To: <20180408145700.23520-1-yixun.lan@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
Message-ID: <20180408145700.23520-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the dt-binding documentation to support new compatible string
for the GPIO interrupt controller which found in Amlogic's Meson-AXG SoC.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index c753d99d43db..89674ad8a097 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -14,6 +14,7 @@ Required properties:
     "amlogic,meson8b-gpio-intc" for meson8b SoCs (S805) or
     "amlogic,meson-gxbb-gpio-intc" for GXBB SoCs (S905) or
     "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
+    "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
 - interrupt-parent : a phandle to the GIC the interrupts are routed to.
    Usually this is provided at the root level of the device tree as it is
    common to most of the SoC.
-- 
2.16.2
