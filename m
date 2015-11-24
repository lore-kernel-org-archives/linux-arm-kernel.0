From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 18:39:20 +0900
Subject: [PATCH 2/4] ARM: dts: uniphier: add better-matching compatible string
 to extbus nodes
In-Reply-To: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1448357962-12259-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to use the UniPhier System Controller driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 3 ++-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 3 ++-
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi    | 3 ++-
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    | 3 ++-
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 3 ++-
 arch/arm/boot/dts/uniphier-proxstream2.dtsi | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index af49381..c2913fe 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -87,7 +87,8 @@
 		interrupt-parent = <&intc>;
 
 		extbus: extbus {
-			compatible = "simple-bus";
+			compatible = "socionext,uniphier-system-bus",
+				     "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index 254642f..d110df7 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -95,7 +95,8 @@
 		interrupt-parent = <&intc>;
 
 		extbus: extbus {
-			compatible = "simple-bus";
+			compatible = "socionext,uniphier-system-bus",
+				     "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
index 11eb762..0f1db60 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
@@ -95,7 +95,8 @@
 		interrupt-parent = <&intc>;
 
 		extbus: extbus {
-			compatible = "simple-bus";
+			compatible = "socionext,uniphier-system-bus",
+				     "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index 691a17d..888bb2e 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -95,7 +95,8 @@
 		interrupt-parent = <&intc>;
 
 		extbus: extbus {
-			compatible = "simple-bus";
+			compatible = "socionext,uniphier-system-bus",
+				     "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index e88559b..b10c4bd 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -87,7 +87,8 @@
 		interrupt-parent = <&intc>;
 
 		extbus: extbus {
-			compatible = "simple-bus";
+			compatible = "socionext,uniphier-system-bus",
+				     "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
index 259f1a9..9186f8c9 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2.dtsi
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -109,7 +109,8 @@
 		interrupt-parent = <&intc>;
 
 		extbus: extbus {
-			compatible = "simple-bus";
+			compatible = "socionext,uniphier-system-bus",
+				     "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <1>;
 		};
-- 
1.9.1
