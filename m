From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:08 +0900
Subject: [PATCH 34/69] ARM: shmobile: Use #include in device tree sources
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <31c46cbf5b8bab87e89028977521c84f2d871040.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

In order to allow usage of the preprocessor in the SoC device tree
sources, switch from /include/ to #include.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai.dts                   | 2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts         | 2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts                   | 2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts           | 2 +-
 arch/arm/boot/dts/r8a7778-bockw-reference.dts           | 2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts                     | 2 +-
 arch/arm/boot/dts/r8a7779-marzen-reference.dts          | 2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts                    | 2 +-
 arch/arm/boot/dts/r8a7790-lager-reference.dts           | 2 +-
 arch/arm/boot/dts/r8a7790-lager.dts                     | 2 +-
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts         | 2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts                   | 2 +-
 arch/arm/boot/dts/sh7372-mackerel.dts                   | 2 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts            | 2 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts                      | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 1fb20f2..b1deaf7 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "r7s72100.dtsi"
+#include "r7s72100.dtsi"
 
 / {
 	model = "Genmai";
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 25dbc1c..338f0cb 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a73a4.dtsi"
+#include "r8a73a4.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 91436b5..7db8d79 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a73a4.dtsi"
+#include "r8a73a4.dtsi"
 
 / {
 	model = "APE6EVM";
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 6a54219..c7c5bcb 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7740.dtsi"
+#include "r8a7740.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pwm/pwm.h>
 
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 426cd9c..a06a11e 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7740.dtsi"
+#include "r8a7740.dtsi"
 
 / {
 	model = "armadillo 800 eva";
diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index f488c48..be9b753 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -15,7 +15,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7778.dtsi"
+#include "r8a7778.dtsi"
 
 / {
 	model = "bockw";
diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 12bbebc..46a884d 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -15,7 +15,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7778.dtsi"
+#include "r8a7778.dtsi"
 
 / {
 	model = "bockw";
diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index ce3fe9e..08b9ee37 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7779.dtsi"
+#include "r8a7779.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index f3f7f79..a7af2c2 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7779.dtsi"
+#include "r8a7779.dtsi"
 
 / {
 	model = "marzen";
diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index ec82674..cce7dbf 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7790.dtsi"
+#include "r8a7790.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 203bd08..8799dfb 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7790.dtsi"
+#include "r8a7790.dtsi"
 
 / {
 	model = "Lager";
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
index b8a374a..1a0f082 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7791.dtsi"
+#include "r8a7791.dtsi"
 
 / {
 	model = "Koelsch";
diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 1ce5250..c4e8b3a 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-/include/ "r8a7791.dtsi"
+#include "r8a7791.dtsi"
 
 / {
 	model = "Koelsch";
diff --git a/arch/arm/boot/dts/sh7372-mackerel.dts b/arch/arm/boot/dts/sh7372-mackerel.dts
index 8acf51e..a759a27 100644
--- a/arch/arm/boot/dts/sh7372-mackerel.dts
+++ b/arch/arm/boot/dts/sh7372-mackerel.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "sh7372.dtsi"
+#include "sh7372.dtsi"
 
 / {
 	model = "Mackerel (AP4 EVM 2nd)";
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index df75aea..d5a6d74 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -12,7 +12,7 @@
  */
 
 /dts-v1/;
-/include/ "sh73a0.dtsi"
+#include "sh73a0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 0f1ca77..27c5f42 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "sh73a0.dtsi"
+#include "sh73a0.dtsi"
 
 / {
 	model = "KZM-A9-GT";
-- 
1.8.4
