From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 28 Jun 2017 07:53:43 -0700
Subject: [PATCH] dt-bindings: amlogic: add unstable statement
Message-ID: <20170628145343.25443-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the lack of documentation on this SoC family, discovery of new
features, and correcting of previous misunderstandings is expected, so
it's unrealistic to expect any form of stable bindings for this SoC
family.  Make that clear inthe binding documentation.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index bfd5b558477d..9be902b4656d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -1,6 +1,18 @@
 Amlogic MesonX device tree bindings
 -------------------------------------------
 
+Work in progress statement:
+
+Device tree files and bindings applying to Amlogic SoCs and boards are
+considered "unstable". Any Amlogic device tree binding may change at
+any time. Be sure to use a device tree binary and a kernel image
+generated from the same source tree.
+
+Please refer to Documentation/devicetree/bindings/ABI.txt for a definition of a
+stable binding/ABI.
+
+---------------------------------------------------------------
+
 Boards with the Amlogic Meson6 SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,meson6"
-- 
2.9.3
