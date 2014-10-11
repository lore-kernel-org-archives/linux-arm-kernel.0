From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 Oct 2014 17:41:11 +0200
Subject: [PATCH 3/5] phy: berlin-sata: Document BG2 compatible
In-Reply-To: <1413042073-14253-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413042073-14253-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413042073-14253-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Berlin BG2 SATA PHY is slightly different from currently supported
BG2Q SATA PHY. Document the new compatible for BG2's PHY.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Kishon Vijay Abraham I <kishon@ti.com> 
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org 
---
 Documentation/devicetree/bindings/phy/berlin-sata-phy.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
index 88f8c23384c0..c0155f842f62 100644
--- a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
@@ -2,7 +2,9 @@ Berlin SATA PHY
 ---------------
 
 Required properties:
-- compatible: should be "marvell,berlin2q-sata-phy"
+- compatible: should be one of
+    "marvell,berlin2-sata-phy"
+    "marvell,berlin2q-sata-phy"
 - address-cells: should be 1
 - size-cells: should be 0
 - phy-cells: from the generic PHY bindings, must be 1
-- 
2.1.1
