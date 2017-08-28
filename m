From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Mon, 28 Aug 2017 16:20:12 +0200
Subject: [PATCHv2 1/7] dt-bindings: usb: Document the STM32F7 DWC2 USB OTG HS
 core binding
In-Reply-To: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
References: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1503930018-536-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds binding documentation for DWC2 controller in HS mode found
on STMicroelectronics STM32F7 SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index fcf199b..46da5f1 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -19,6 +19,8 @@ Required properties:
   configured in FS mode;
   - "st,stm32f4x9-hsotg": The DWC2 USB HS controller instance in STM32F4x9 SoCs
   configured in HS mode;
+  - "st,stm32f7-hsotg": The DWC2 USB HS controller instance in STM32F7 SoCs
+    configured in HS mode;
 - reg : Should contain 1 register range (address and length)
 - interrupts : Should contain 1 interrupt
 - clocks: clock provider specifier
-- 
2.7.4
