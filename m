From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 18:04:33 +0200
Subject: [PATCH v3 19/23] dt-bindings: thermal: armada: add reference to new
 bindings
In-Reply-To: <20180705160437.12325-1-miquel.raynal@bootlin.com>
References: <20180705160437.12325-1-miquel.raynal@bootlin.com>
Message-ID: <20180705160437.12325-20-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New bindings (with the syscon and the overheat interrupt) are available
for AP806 and CP110 compatibles. Add a reference to these files from the
original documentation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/thermal/armada-thermal.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index e0d013a2e66d..f3b441100890 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -10,6 +10,11 @@ Required properties:
     * marvell,armada-ap806-thermal
     * marvell,armada-cp110-thermal
 
+Note: these bindings are deprecated for AP806/CP110 and should instead
+follow the rules described in:
+Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+
 - reg: Device's register space.
   Two entries are expected, see the examples below. The first one points
   to the status register (4B). The second one points to the control
-- 
2.14.1
