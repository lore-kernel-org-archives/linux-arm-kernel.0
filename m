From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Thu, 16 Jun 2016 09:53:31 -0400
Subject: [PATCH 3/7] dt-bindings: phy: Add documentation for NSP SATA PHY
In-Reply-To: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1466085215-10246-4-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for SATA PHY available in Broadcom's
NSP SoC.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
index d023120..6ccce09 100644
--- a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
@@ -5,6 +5,7 @@ Required properties:
      "brcm,bcm7425-sata-phy"
      "brcm,bcm7445-sata-phy"
      "brcm,iproc-ns2-sata-phy"
+     "brcm,iproc-nsp-sata-phy"
      "brcm,phy-sata3"
 - address-cells: should be 1
 - size-cells: should be 0
@@ -22,7 +23,8 @@ Sub-nodes required properties:
 
 Sub-nodes optional properties:
 - brcm,enable-ssc: use spread spectrum clocking (SSC) on this port
-     This property is not applicable for "brcm,iproc-ns2-sata-phy".
+     This property is not applicable for "brcm,iproc-ns2-sata-phy" and
+     "brcm,iproc-nsp-sata-phy".
 
 Example:
 	sata-phy at f0458100 {
-- 
2.1.0
