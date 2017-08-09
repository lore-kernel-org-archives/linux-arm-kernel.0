From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 01:43:28 +0900
Subject: [PATCH 3/6] arm64: dts: uniphier: use #include instead of /include/
In-Reply-To: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
References: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1502297011-30201-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To include dt-bindings headers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    | 6 +++---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    | 6 +++---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 115357018ef7..bc3099a0d38f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-ld11.dtsi"
+#include "uniphier-ld11.dtsi"
 
 / {
 	model = "UniPhier LD11 Global Board (REF_LD11_GP)";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index cc8ebe34c27c..ffb473ad2e0f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-ld11.dtsi"
-/include/ "uniphier-ref-daughter.dtsi"
-/include/ "uniphier-support-card.dtsi"
+#include "uniphier-ld11.dtsi"
+#include "uniphier-ref-daughter.dtsi"
+#include "uniphier-support-card.dtsi"
 
 / {
 	model = "UniPhier LD11 Reference Board";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index bdce5b89baec..e420268295d9 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -371,4 +371,4 @@
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+#include "uniphier-pinctrl.dtsi"
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 9f620d4101b5..763c4d86b12c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-ld20.dtsi"
+#include "uniphier-ld20.dtsi"
 
 / {
 	model = "UniPhier LD20 Global Board (REF_LD20_GP)";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 494166aee24c..1ca0c8620dc5 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -8,9 +8,9 @@
  */
 
 /dts-v1/;
-/include/ "uniphier-ld20.dtsi"
-/include/ "uniphier-ref-daughter.dtsi"
-/include/ "uniphier-support-card.dtsi"
+#include "uniphier-ld20.dtsi"
+#include "uniphier-ref-daughter.dtsi"
+#include "uniphier-support-card.dtsi"
 
 / {
 	model = "UniPhier LD20 Reference Board";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index de1e75362817..5cdd7a9db412 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -392,4 +392,4 @@
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+#include "uniphier-pinctrl.dtsi"
-- 
2.7.4
