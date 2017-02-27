From: eric@anholt.net (Eric Anholt)
Date: Mon, 27 Feb 2017 12:28:01 -0800
Subject: [PATCH v2 1/3] dt-bindings: Document the dmas and dma-names
 properties for VC4 HDMI
Message-ID: <20170227202803.12855-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

These are optional, but necessary for HDMI audio support.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Rob Herring <robh@kernel.org>
---

v2: no changes

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
