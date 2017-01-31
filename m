From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 31 Jan 2017 22:21:12 +0100
Subject: [PATCH] Documentation: devicetree: meson-ir: "linux,
 rc-map-name" is supported
Message-ID: <20170131212112.5582-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver already parses the "linux,rc-map-name" property. Add this
information to the documentation so .dts maintainers don't have to look
it up in the source-code.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/media/meson-ir.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/meson-ir.txt b/Documentation/devicetree/bindings/media/meson-ir.txt
index e7e3f3c4fc8f..efd9d29a8f10 100644
--- a/Documentation/devicetree/bindings/media/meson-ir.txt
+++ b/Documentation/devicetree/bindings/media/meson-ir.txt
@@ -8,6 +8,9 @@ Required properties:
  - reg		: physical base address and length of the device registers
  - interrupts	: a single specifier for the interrupt from the device
 
+Optional properties:
+ - linux,rc-map-name:	see rc.txt file in the same directory.
+
 Example:
 
 	ir-receiver at c8100480 {
-- 
2.11.0
