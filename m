From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  1 Nov 2016 16:04:37 -0400
Subject: [PATCH v4 2/7] Documentation: devicetree: add PHY lane swap binding
In-Reply-To: <1478030682-27012-1-git-send-email-jon.mason@broadcom.com>
References: <1478030682-27012-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1478030682-27012-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for PHY lane swapping.  This is a boolean entry to
notify the phy device drivers that the TX/RX lanes need to be swapped.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 Documentation/devicetree/bindings/net/phy.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index bc1c3c8..3dce607 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -35,6 +35,9 @@ Optional Properties:
 - broken-turn-around: If set, indicates the PHY device does not correctly
   release the turn around line low at the end of a MDIO transaction.
 
+- enet-phy-lane-swap: If set, indicates the PHY device requires swapping the
+  TX/RX lanes to function properly.
+
 Example:
 
 ethernet-phy at 0 {
-- 
2.7.4
