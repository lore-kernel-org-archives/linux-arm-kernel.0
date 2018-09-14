From: phil@raspberrypi.org (Phil Elwell)
Date: Fri, 14 Sep 2018 14:22:53 +0100
Subject: [PATCH v2 2/4] dt-bindings: soc: Document "brcm,bcm2836-vchiq"
In-Reply-To: <1536931375-48769-1-git-send-email-phil@raspberrypi.org>
References: <1536931375-48769-1-git-send-email-phil@raspberrypi.org>
Message-ID: <1536931375-48769-3-git-send-email-phil@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"brcm,bcm2836-vchiq" should be used on BCM2836 and BCM2837 to ensure
correct operation.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
index 8dd7b3a..f331316 100644
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
@@ -2,7 +2,8 @@ Broadcom VCHIQ firmware services
 
 Required properties:
 
-- compatible:	Should be "brcm,bcm2835-vchiq"
+- compatible:	Should be "brcm,bcm2835-vchiq" on BCM2835, otherwise
+		"brcm,bcm2836-vchiq".
 - reg:		Physical base address and length of the doorbell register pair
 - interrupts:	The interrupt number
 		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
-- 
2.7.4
