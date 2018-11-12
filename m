From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 12 Nov 2018 12:31:02 +0000
Subject: [RFC PATCH 4/6] dt-bindings: update mvneta binding document
In-Reply-To: <20181112122933.GD30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
Message-ID: <E1gMBMs-00089t-Fd@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
index bedcfd5a52cd..691f886cfc4a 100644
--- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
+++ b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
@@ -19,7 +19,7 @@
   "marvell,armada-370-neta" and 9800B for others.
 - clock-names: List of names corresponding to clocks property; shall be
   "core" for core clock and "bus" for the optional bus clock.
-
+- phys: comphy for the ethernet port, see ../phy/phy-bindings.txt
 
 Optional properties (valid only for Armada XP/38x):
 
-- 
2.7.4
