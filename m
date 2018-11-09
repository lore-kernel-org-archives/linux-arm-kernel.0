From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  9 Nov 2018 10:42:06 +0900
Subject: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset
 description
In-Reply-To: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible strings for reset control of AHCI core implemented in
UniPhier SoCs. The reset control belongs to AHCI glue layer.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index f63c511..ea00517 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -133,6 +133,9 @@ Required properties:
     "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
     "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
     "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
+    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
+    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
+    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI
 - #reset-cells: Should be 1.
 - reg: Specifies offset and length of the register set for the device.
 - clocks: A list of phandles to the clock gate for the glue layer.
-- 
2.7.4
