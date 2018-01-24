From: marcofrk@gmail.com (Marco Franchi)
Date: Wed, 24 Jan 2018 11:22:13 -0200
Subject: [PATCH v3 2/3] ARM: dts: imx: Remove empty memory size nodes
In-Reply-To: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
Message-ID: <1516800134-5018-2-git-send-email-marcofrk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the empty reg property from the SoC dtsi files in order to avoid
duplicate memory nodes when the correct size is passed in board dts files.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Change since v2:
-none
 arch/arm/boot/dts/imx1.dtsi    | 2 +-
 arch/arm/boot/dts/imx23.dtsi   | 2 +-
 arch/arm/boot/dts/imx25.dtsi   | 2 +-
 arch/arm/boot/dts/imx27.dtsi   | 2 +-
 arch/arm/boot/dts/imx28.dtsi   | 2 +-
 arch/arm/boot/dts/imx31.dtsi   | 2 +-
 arch/arm/boot/dts/imx35.dtsi   | 2 +-
 arch/arm/boot/dts/imx50.dtsi   | 2 +-
 arch/arm/boot/dts/imx51.dtsi   | 2 +-
 arch/arm/boot/dts/imx53.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 20f6565..f7b9edf 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -25,7 +25,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		gpio0 = &gpio1;
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 10d57f9..0aa111e 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -23,7 +23,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		gpio0 = &gpio0;
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 9445f8e..9725705 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -22,7 +22,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 15d85f1..6585b00 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -26,7 +26,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e52e05c..42d9a89 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -24,7 +24,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &mac0;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index a720314..ebc3f2d 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -19,7 +19,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		serial0 = &uart1;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index e08c0c1..bf343195 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -20,7 +20,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 35955e6..7954e79 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -25,7 +25,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 00d30bd..5d390a6 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -26,7 +26,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 1040251..7d647d0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -26,7 +26,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 59ff866..0c70ea8 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -23,7 +23,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ae8df3c..ab6a7e2 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -21,7 +21,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index fd78793..c486791 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -22,7 +22,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		can0 = &flexcan1;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 5d6c3ba..c6515a3 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -22,7 +22,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec1;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 9aa2bb9..ec6292c 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -58,7 +58,7 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory { device_type = "memory"; };
 
 	aliases {
 		gpio0 = &gpio1;
-- 
2.7.4
