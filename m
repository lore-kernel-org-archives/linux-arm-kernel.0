From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 28 Nov 2017 15:02:15 +0000
Subject: [PATCH v2 04/16] ARM: dts: imx6qdl: SolidRun: move microsom includes
 into .dts
In-Reply-To: <20171128150045.GV31757@n2100.armlinux.org.uk>
References: <20171128150045.GV31757@n2100.armlinux.org.uk>
Message-ID: <E1eJhOp-0006NO-Ci@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the microsom includes into the .dts files so different options can
be accomodated at the lowest level.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6dl-cubox-i.dts        | 1 +
 arch/arm/boot/dts/imx6dl-hummingboard.dts   | 1 +
 arch/arm/boot/dts/imx6q-cubox-i.dts         | 1 +
 arch/arm/boot/dts/imx6q-hummingboard.dts    | 1 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi      | 1 -
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 1 -
 6 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-cubox-i.dts b/arch/arm/boot/dts/imx6dl-cubox-i.dts
index f10a36b8647d..045e59de5ffe 100644
--- a/arch/arm/boot/dts/imx6dl-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6dl-cubox-i.dts
@@ -41,6 +41,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 #include "imx6qdl-cubox-i.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
index 39c2602fa87c..c3b826f4cab9 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
@@ -42,6 +42,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 #include "imx6qdl-hummingboard.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
index b68aa0e57f20..b9f581d0fa86 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -41,6 +41,7 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 #include "imx6qdl-cubox-i.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6q-hummingboard.dts b/arch/arm/boot/dts/imx6q-hummingboard.dts
index 69a7a0a1cb21..5f218856c3e5 100644
--- a/arch/arm/boot/dts/imx6q-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6q-hummingboard.dts
@@ -42,6 +42,7 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 #include "imx6qdl-hummingboard.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 0bc1734d8bdf..98ec7ce1f2a3 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -38,7 +38,6 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "imx6qdl-sr-som.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 246984992ad0..84e6392fee1f 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -38,7 +38,6 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "imx6qdl-sr-som.dtsi"
 
 / {
 	chosen {
-- 
2.7.4
