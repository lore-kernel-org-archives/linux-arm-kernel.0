From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 01:43:27 +0900
Subject: [PATCH 2/6] ARM: dts: uniphier use #incluude instead of /include/
In-Reply-To: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
References: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1502297011-30201-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To include dt-bindings headers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts     | 6 +++---
 arch/arm/boot/dts/uniphier-ld4.dtsi        | 2 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts    | 6 +++---
 arch/arm/boot/dts/uniphier-ld6b.dtsi       | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts    | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts    | 6 +++---
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  | 2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi       | 2 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi       | 2 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 2 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  | 2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 2 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts    | 6 +++---
 arch/arm/boot/dts/uniphier-sld8.dtsi       | 2 +-
 14 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index 4817ebb28eb2..86b089e9c163 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-ld4.dtsi"
-/include/ "uniphier-ref-daughter.dtsi"
-/include/ "uniphier-support-card.dtsi"
+#include "uniphier-ld4.dtsi"
+#include "uniphier-ref-daughter.dtsi"
+#include "uniphier-support-card.dtsi"
 
 / {
 	model = "UniPhier LD4 Reference Board";
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index fb2fd9605b9d..5d3924c8568c 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -288,4 +288,4 @@
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+#include "uniphier-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 96db4abc02c3..6dbdc86225e9 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-ld6b.dtsi"
-/include/ "uniphier-ref-daughter.dtsi"
-/include/ "uniphier-support-card.dtsi"
+#include "uniphier-ld6b.dtsi"
+#include "uniphier-ref-daughter.dtsi"
+#include "uniphier-support-card.dtsi"
 
 / {
 	model = "UniPhier LD6b Reference Board";
diff --git a/arch/arm/boot/dts/uniphier-ld6b.dtsi b/arch/arm/boot/dts/uniphier-ld6b.dtsi
index 8b9a79731bd3..9a7b25cc8233 100644
--- a/arch/arm/boot/dts/uniphier-ld6b.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld6b.dtsi
@@ -12,7 +12,7 @@
  * The D-chip (digital chip) is the same as the PXs2 die.
  * Reuse the PXs2 device tree with some properties overridden.
  */
-/include/ "uniphier-pxs2.dtsi"
+#include "uniphier-pxs2.dtsi"
 
 / {
 	compatible = "socionext,uniphier-ld6b";
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index 11690b57931c..089419cee273 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -8,7 +8,7 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-pro4.dtsi"
+#include "uniphier-pro4.dtsi"
 
 / {
 	model = "UniPhier Pro4 Ace Board";
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 4cf539245f2e..d3be37b2ac35 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-pro4.dtsi"
-/include/ "uniphier-ref-daughter.dtsi"
-/include/ "uniphier-support-card.dtsi"
+#include "uniphier-pro4.dtsi"
+#include "uniphier-ref-daughter.dtsi"
+#include "uniphier-support-card.dtsi"
 
 / {
 	model = "UniPhier Pro4 Reference Board";
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index 2763cebcd76a..adef212b45b2 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -8,7 +8,7 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-pro4.dtsi"
+#include "uniphier-pro4.dtsi"
 
 / {
 	model = "UniPhier Pro4 Sanji Board";
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 37400becf4ba..394b35e1082d 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -308,4 +308,4 @@
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+#include "uniphier-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 140327ddde1c..df0506b58330 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -371,4 +371,4 @@
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+#include "uniphier-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index 81560f75bfa7..7dfae2667f50 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -8,7 +8,7 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-pxs2.dtsi"
+#include "uniphier-pxs2.dtsi"
 
 / {
 	model = "UniPhier PXs2 Gentil Board";
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index dc2d0579c666..0cf615463a82 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -8,7 +8,7 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-pxs2.dtsi"
+#include "uniphier-pxs2.dtsi"
 
 / {
 	model = "UniPhier PXs2 Vodka Board";
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index bace751d4023..c26d4ba1b9c3 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -355,4 +355,4 @@
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+#include "uniphier-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index 4536d5b71297..394f5df62eda 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-sld8.dtsi"
-/include/ "uniphier-ref-daughter.dtsi"
-/include/ "uniphier-support-card.dtsi"
+#include "uniphier-sld8.dtsi"
+#include "uniphier-ref-daughter.dtsi"
+#include "uniphier-support-card.dtsi"
 
 / {
 	model = "UniPhier sLD8 Reference Board";
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 9fb9167f2db4..0c022fa5640c 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -288,4 +288,4 @@
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+#include "uniphier-pinctrl.dtsi"
-- 
2.7.4
