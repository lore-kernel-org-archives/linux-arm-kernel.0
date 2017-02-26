From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 26 Feb 2017 14:04:08 +0900
Subject: [PATCH 2/3] ARM: dts: uniphier: fix no unit name warnings
In-Reply-To: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
References: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1488085449-28922-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warnings reported when built with W=1:
  Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts       | 2 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts      | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts      | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts      | 2 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts    | 2 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts   | 2 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts    | 2 +-
 arch/arm/boot/dts/uniphier-sld3-ref.dts      | 2 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts      | 2 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index 110031b..77163b3 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -52,7 +52,7 @@
 	model = "UniPhier LD4 Reference Board";
 	compatible = "socionext,uniphier-ld4-ref", "socionext,uniphier-ld4";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index c05d631..467ad6a 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -52,7 +52,7 @@
 	model = "UniPhier LD6b Reference Board";
 	compatible = "socionext,uniphier-ld6b-ref", "socionext,uniphier-ld6b";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index 0ab0a40..a10a5fa 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -50,7 +50,7 @@
 	model = "UniPhier Pro4 Ace Board";
 	compatible = "socionext,uniphier-pro4-ace", "socionext,uniphier-pro4";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 9e92e60..58a2cba 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -52,7 +52,7 @@
 	model = "UniPhier Pro4 Reference Board";
 	compatible = "socionext,uniphier-pro4-ref", "socionext,uniphier-pro4";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index dc4ea88..1508eeb 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -50,7 +50,7 @@
 	model = "UniPhier Pro4 Sanji Board";
 	compatible = "socionext,uniphier-pro4-sanji", "socionext,uniphier-pro4";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index 373818a..e26ed59 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -51,7 +51,7 @@
 	compatible = "socionext,uniphier-pxs2-gentil",
 		     "socionext,uniphier-pxs2";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index 51a3eac..a28e9e4 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -50,7 +50,7 @@
 	model = "UniPhier PXs2 Vodka Board";
 	compatible = "socionext,uniphier-pxs2-vodka", "socionext,uniphier-pxs2";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-sld3-ref.dts b/arch/arm/boot/dts/uniphier-sld3-ref.dts
index ac792ae0..827c821 100644
--- a/arch/arm/boot/dts/uniphier-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld3-ref.dts
@@ -52,7 +52,7 @@
 	model = "UniPhier sLD3 Reference Board";
 	compatible = "socionext,uniphier-sld3-ref", "socionext,uniphier-sld3";
 
-	memory {
+	memory at 8000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000
 		       0xc0000000 0x20000000>;
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index a8291f9..93c3dd9 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -52,7 +52,7 @@
 	model = "UniPhier sLD8 Reference Board";
 	compatible = "socionext,uniphier-sld8-ref", "socionext,uniphier-sld8";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index 51ecc9b9..22da112 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -46,7 +46,7 @@
 	status = "okay";
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
 
-	support_card: support_card {
+	support_card: support_card at 1,1f00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.7.4
