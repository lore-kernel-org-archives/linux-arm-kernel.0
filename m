From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 18:39:21 +0900
Subject: [PATCH 3/4] ARM: dts: uniphier: rename nodes from extbus to system-bus
In-Reply-To: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1448357962-12259-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The officially documented name for this hardware is System Bus, so
follow that naming.  It also corresponds to the compatible string.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts   | 2 +-
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi      | 2 +-
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts  | 2 +-
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts  | 2 +-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi     | 2 +-
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi     | 2 +-
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts  | 2 +-
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi     | 2 +-
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts  | 2 +-
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi     | 2 +-
 arch/arm/boot/dts/uniphier-proxstream2.dtsi  | 2 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
index f1e9d40..c625b4d 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -72,7 +72,7 @@
 	};
 };
 
-&extbus {
+&system_bus {
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index c2913fe..0e2ba55 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -86,7 +86,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
+		system_bus: system-bus {
 			compatible = "socionext,uniphier-system-bus",
 				     "simple-bus";
 			#address-cells = <2>;
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
index 5baa9fc..3ac89fb 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
@@ -74,7 +74,7 @@
 	};
 };
 
-&extbus {
+&system_bus {
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
index 2462668..0c82353 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -74,7 +74,7 @@
 	};
 };
 
-&extbus {
+&system_bus {
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index d110df7..09f78fa 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -94,7 +94,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
+		system_bus: system-bus {
 			compatible = "socionext,uniphier-system-bus",
 				     "simple-bus";
 			#address-cells = <2>;
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
index 0f1db60..f5aa24c 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
@@ -94,7 +94,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
+		system_bus: system-bus {
 			compatible = "socionext,uniphier-system-bus",
 				     "simple-bus";
 			#address-cells = <2>;
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
index b7a03215..29e8123 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -73,7 +73,7 @@
 	};
 };
 
-&extbus {
+&system_bus {
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index 888bb2e..d830ea9 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -94,7 +94,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
+		system_bus: system-bus {
 			compatible = "socionext,uniphier-system-bus",
 				     "simple-bus";
 			#address-cells = <2>;
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
index fc7250c..eb605d6 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -72,7 +72,7 @@
 	};
 };
 
-&extbus {
+&system_bus {
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index b10c4bd..711a3f7 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -86,7 +86,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
+		system_bus: system-bus {
 			compatible = "socionext,uniphier-system-bus",
 				     "simple-bus";
 			#address-cells = <2>;
diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
index 9186f8c9..ff4977c 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2.dtsi
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -108,7 +108,7 @@
 		ranges;
 		interrupt-parent = <&intc>;
 
-		extbus: extbus {
+		system_bus: system-bus {
 			compatible = "socionext,uniphier-system-bus",
 				     "simple-bus";
 			#address-cells = <2>;
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index da271e3..e8c9b49 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-&extbus {
+&system_bus {
 	support_card: support_card {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.9.1
