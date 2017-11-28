From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 28 Nov 2017 16:29:10 +0900
Subject: [PATCH] dt-bindings: uniphier: add bindings for UniPhier SoC family
Message-ID: <1511854150-26346-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/devicetree/bindings/arm/uniphier.txt | 40 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/uniphier.txt

diff --git a/Documentation/devicetree/bindings/arm/uniphier.txt b/Documentation/devicetree/bindings/arm/uniphier.txt
new file mode 100644
index 0000000..08d3cf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/uniphier.txt
@@ -0,0 +1,40 @@
+Socionext UniPhier SoC family
+
+Required properties in the root node:
+  - compatible: should contain board and SoC compatible strings
+
+    SoC compatibles:
+      - "socionext,uniphier-ld4"   - LD4 SoC
+      - "socionext,uniphier-pro4"  - Pro4 SoC
+      - "socionext,uniphier-sld8"  - sLD8 SoC
+      - "socionext,uniphier-pro5"  - Pro5 SoC
+      - "socionext,uniphier-pxs2"  - PXs2 SoC
+      - "socionext,uniphier-ld6b"  - LD6b SoC
+      - "socionext,uniphier-ld11"  - LD11 SoC
+      - "socionext,uniphier-ld20"  - LD20 SoC
+      - "socionext,uniphier-pxs3"  - PXs3 SoC
+
+    Board compatibles:
+      - "socionext,uniphier-ld4-ref"      - LD4 Reference Board
+      - "socionext,uniphier-pro4-ref"     - Pro4 Reference Board
+      - "socionext,uniphier-pro4-ace"     - Pro4 Ace Board
+      - "socionext,uniphier-pro4-sanji"   - Pro4 Sanji Board
+      - "socionext,uniphier-sld8-ref"     - sLD8 Reference Board
+      - "socionext,uniphier-pxs2-gentil"  - PXs2 Gentil Board
+      - "socionext,uniphier-pxs2-vodka"   - PXs2 Vodka Board
+      - "socionext,uniphier-ld6b-ref"     - LD6b Reference Board
+      - "socionext,uniphier-ld11-ref"     - LD11 Reference Board
+      - "socionext,uniphier-ld11-global"  - LD11 Global Board
+      - "socionext,uniphier-ld20-ref"     - LD20 Reference Board
+      - "socionext,uniphier-ld20-global"  - LD20 Global Board
+      - "socionext,uniphier-pxs3-ref"     - PXs3 Reference Board
+
+Example:
+
+/dts-v1/;
+
+/ {
+	compatible = "socionext,uniphier-ld20-ref", "socionext,uniphier-ld20";
+
+	...
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index cbb89bb..1fcbd65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2041,6 +2041,7 @@ M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/arm/uniphier.txt
 F:	Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 F:	arch/arm/boot/dts/uniphier*
 F:	arch/arm/include/asm/hardware/cache-uniphier.h
-- 
2.7.4
