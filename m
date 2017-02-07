From: eric@anholt.net (Eric Anholt)
Date: Tue,  7 Feb 2017 13:07:01 -0800
Subject: [PATCH 1/3] dt-bindings: Document the dmas and dma-names properties
 for VC4 HDMI
Message-ID: <20170207210703.7082-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

These are optional, but necessary for HDMI audio support.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
index 34c7fddcea39..ca02d3e4db91 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
+++ b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
@@ -34,6 +34,9 @@ Optional properties for HDMI:
 - hpd-gpios:	The GPIO pin for HDMI hotplug detect (if it doesn't appear
 		  as an interrupt/status bit in the HDMI controller
 		  itself).  See bindings/pinctrl/brcm,bcm2835-gpio.txt
+- dmas:		Should contain one entry pointing to the DMA channel used to
+		transfer audio data
+- dma-names:	Should contain "audio-rx"
 
 Required properties for DPI:
 - compatible:	Should be "brcm,bcm2835-dpi"
-- 
2.11.0
