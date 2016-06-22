From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 21 Jun 2016 23:25:49 -0300
Subject: [PATCH 3/3] dt-bindings: Document the STM32 USB OTG DWC2 core binding
In-Reply-To: <1466562349-5043-1-git-send-email-bruherrera@gmail.com>
References: <1466562349-5043-1-git-send-email-bruherrera@gmail.com>
Message-ID: <1466562349-5043-3-git-send-email-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 20a68bf..79e5370 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -11,6 +11,7 @@ Required properties:
   - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
   - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;
   - snps,dwc2: A generic DWC2 USB controller with default parameters.
+  - st,stm32-fsotg: The DWC2 USB controller instance in STM32F4 SoCs in FS mode;
 - reg : Should contain 1 register range (address and length)
 - interrupts : Should contain 1 interrupt
 - clocks: clock provider specifier
-- 
2.7.4 (Apple Git-66)
