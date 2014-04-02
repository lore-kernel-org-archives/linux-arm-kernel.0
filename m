From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  2 Apr 2014 22:57:17 +0200
Subject: [PATCH] ARM: socfpga: dts: convert to preprocessor includes
Message-ID: <1396472237-6341-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all socfpga DT files to the dtc preprocessor include syntax.
This allows to include header files in the devicetrees like other
SoC-types already do.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi                  | 2 +-
 arch/arm/boot/dts/socfpga_arria5.dtsi           | 2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts      | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5.dtsi         | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts    | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts   | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 2 +-
 arch/arm/boot/dts/socfpga_vt.dts                | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index c8ced33..1f71e96 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -15,7 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	#address-cells = <1>;
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index a85b404..43b921a 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -15,7 +15,7 @@
  */
 
 /dts-v1/;
-/include/ "socfpga.dtsi"
+#include "socfpga.dtsi"
 
 / {
 	soc {
diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index 5beffb2..b3901a3 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -15,7 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-/include/ "socfpga_arria5.dtsi"
+#include "socfpga_arria5.dtsi"
 
 / {
 	model = "Altera SOCFPGA Arria V SoC Development Kit";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index a8716f6..d9dfc01 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -16,7 +16,7 @@
  */
 
 /dts-v1/;
-/include/ "socfpga.dtsi"
+#include "socfpga.dtsi"
 
 / {
 	soc {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 2ee52ab..593fbfe 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -15,7 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-/include/ "socfpga_cyclone5.dtsi"
+#include "socfpga_cyclone5.dtsi"
 
 / {
 	model = "Altera SOCFPGA Cyclone V SoC Development Kit";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 50b99a2..6cb1283 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -15,7 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-/include/ "socfpga_cyclone5.dtsi"
+#include "socfpga_cyclone5.dtsi"
 
 / {
 	model = "Terasic SoCkit";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index f8d17dc..a1814b4 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -15,7 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-/include/ "socfpga_cyclone5.dtsi"
+#include "socfpga_cyclone5.dtsi"
 
 / {
 	model = "EBV SOCrates";
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index d1ec0ca..70f0cb2d 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -16,7 +16,7 @@
  */
 
 /dts-v1/;
-/include/ "socfpga.dtsi"
+#include "socfpga.dtsi"
 
 / {
 	model = "Altera SOCFPGA VT";
-- 
1.9.1
