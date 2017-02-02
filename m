From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  2 Feb 2017 17:47:44 +0100
Subject: [PATCH] dt-bindings: net: remove reference to fixed link support
Message-ID: <1486054064-31093-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contrary to what the Device Tree binding indicates, the binding for the
PPv2 network device currently doesn't provide any fixed link
functionality. This commit adjusts the Device Tree binding documentation
accordingly.

Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/net/marvell-pp2.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell-pp2.txt b/Documentation/devicetree/bindings/net/marvell-pp2.txt
index aa4f423..4754364 100644
--- a/Documentation/devicetree/bindings/net/marvell-pp2.txt
+++ b/Documentation/devicetree/bindings/net/marvell-pp2.txt
@@ -27,9 +27,7 @@ Optional properties (port):
 
 - marvell,loopback: port is loopback mode
 - phy: a phandle to a phy node defining the PHY address (as the reg
-  property, a single integer). Note: if this property isn't present,
-  then fixed link is assumed, and the 'fixed-link' property is
-  mandatory.
+  property, a single integer).
 
 Example:
 
-- 
2.7.4
