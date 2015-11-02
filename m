From: jonmason@broadcom.com (Jon Mason)
Date: Mon, 2 Nov 2015 13:34:52 -0500
Subject: [PATCH RESEND v4 1/2] dt-bindings: Add new SoCs to bcm4708 DT bindings
In-Reply-To: <1446489293-25088-1-git-send-email-jonmason@broadcom.com>
References: <1446489293-25088-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1446489293-25088-2-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 4708, 4709, and 53012 SoCs to the the documentation for the
Broadcom Northstar device tree bindings.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Scott Branden <sbranden@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
index 6b0f49f..8608a77 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
@@ -5,4 +5,11 @@ Boards with the BCM4708 SoC shall have the following properties:
 
 Required root node property:
 
+bcm4708
 compatible = "brcm,bcm4708";
+
+bcm4709
+compatible = "brcm,bcm4709";
+
+bcm53012
+compatible = "brcm,bcm53012";
-- 
1.9.1
