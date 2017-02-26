From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 26 Feb 2017 14:04:07 +0900
Subject: [PATCH 1/3] ARM: dts: uniphier: remove skeleton.dtsi inclusion
In-Reply-To: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
References: <1488085449-28922-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1488085449-28922-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9c0da3cc61f1 ("ARM: dts: explicitly mark skeleton.dtsi as
deprecated") declared that skeleton.dtsi was deprecated.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 4 ++--
 arch/arm/boot/dts/uniphier-pro4.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-pro5.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-sld3.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-sld8.dtsi | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index a7c494d..4f5fe15 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -43,10 +43,10 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
-
 / {
 	compatible = "socionext,uniphier-ld4";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index e960b09..794a85a 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -43,10 +43,10 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
-
 / {
 	compatible = "socionext,uniphier-pro4";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index dbc5e53..df07b55 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -43,10 +43,10 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
-
 / {
 	compatible = "socionext,uniphier-pro5";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index e9e031d..58c3e2f 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -43,10 +43,10 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
-
 / {
 	compatible = "socionext,uniphier-pxs2";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-sld3.dtsi b/arch/arm/boot/dts/uniphier-sld3.dtsi
index 9fad6bd..01d77ed 100644
--- a/arch/arm/boot/dts/uniphier-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld3.dtsi
@@ -43,10 +43,10 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
-
 / {
 	compatible = "socionext,uniphier-sld3";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index b2c980e..eb06fdc 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -43,10 +43,10 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
-
 / {
 	compatible = "socionext,uniphier-sld8";
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
-- 
2.7.4
