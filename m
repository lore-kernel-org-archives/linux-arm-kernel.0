From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sun, 8 Apr 2018 14:56:58 +0000
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: fix the double quotes
In-Reply-To: <20180408145700.23520-1-yixun.lan@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
Message-ID: <20180408145700.23520-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The double quotes seems not ASCII type, fix it here.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index a83f9a5734ca..c753d99d43db 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -9,11 +9,11 @@ number of interrupt exposed depends on the SoC.
 
 Required properties:
 
-- compatible : must have "amlogic,meson8-gpio-intc? and either
-   ?amlogic,meson8-gpio-intc? for meson8 SoCs (S802) or
-   ?amlogic,meson8b-gpio-intc? for meson8b SoCs (S805) or
-   ?amlogic,meson-gxbb-gpio-intc? for GXBB SoCs (S905) or
-   ?amlogic,meson-gxl-gpio-intc? for GXL SoCs (S905X, S912)
+- compatible : must have "amlogic,meson8-gpio-intc" and either
+    "amlogic,meson8-gpio-intc" for meson8 SoCs (S802) or
+    "amlogic,meson8b-gpio-intc" for meson8b SoCs (S805) or
+    "amlogic,meson-gxbb-gpio-intc" for GXBB SoCs (S905) or
+    "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
 - interrupt-parent : a phandle to the GIC the interrupts are routed to.
    Usually this is provided at the root level of the device tree as it is
    common to most of the SoC.
-- 
2.16.2
