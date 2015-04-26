From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Sun, 26 Apr 2015 16:03:58 +0200
Subject: [PATCH] Documentation: bindings: berlin: consider our dt bindings as
 unstable
Message-ID: <1430057038-12967-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the support of Marvell Berlin SoCs is still a work in progress,
add a statement to explicitly consider our device tree files and
bindings as unstable.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell,berlin.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index a99eb9eb14c0..060daafc14ff 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -1,6 +1,18 @@
 Marvell Berlin SoC Family Device Tree Bindings
 ---------------------------------------------------------------
 
+Work in progress statement:
+
+Device tree files and bindings applying to Marvell Berlin SoCs and boards are
+considered "unstable". Any Marvell Berlin device tree binding may change at any
+time. Be sure to use a device tree binary and a kernel image generated from the
+same source tree.
+
+Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
+stable binding/ABI.
+
+---------------------------------------------------------------
+
 Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
 shall have the following properties:
 
-- 
2.3.6
