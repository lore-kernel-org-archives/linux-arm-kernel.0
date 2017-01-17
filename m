From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 17 Jan 2017 14:12:37 -0200
Subject: [PATCH v3 5/5] dt-bindings: Document the STM32 USB OTG DWC2 core
 binding
In-Reply-To: <20170117161237.3802-1-bruherrera@gmail.com>
References: <20170117161237.3802-1-bruherrera@gmail.com>
Message-ID: <20170117161237.3802-6-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the documentation for STM32F4x9 USB OTG FS/HS compatible strings.

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 6c7c2bce..637223a 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -14,6 +14,10 @@ Required properties:
   - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
   - "amcc,dwc-otg": The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs;
   - snps,dwc2: A generic DWC2 USB controller with default parameters.
+  - "st,stm32f4xx-fsotg": The DWC2 USB FS/HS controller instance in STM32F4xx SoCs
+  configured in FS mode;
+  - "st,stm32f4xx-hsotg": The DWC2 USB HS controller instance in STM32F4xx SoCs
+  configured in HS mode;
 - reg : Should contain 1 register range (address and length)
 - interrupts : Should contain 1 interrupt
 - clocks: clock provider specifier
-- 
2.10.1 (Apple Git-78)
