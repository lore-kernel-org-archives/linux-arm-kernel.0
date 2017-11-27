From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 16:52:20 +0000
Subject: [PATCH 03/13] ARM: dts: imx6qdl: SolidRun: move microsom includes
 into .dts
In-Reply-To: <20171127165134.GH31757@n2100.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
Message-ID: <E1eJMdo-0002qf-2D@rmk-PC.armlinux.org.uk>
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
index f10a36b8647d..222c269f687a 100644
--- a/arch/arm/boot/dts/imx6dl-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6dl-cubox-i.dts
@@ -41,6 +41,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
+#include "imx6qdl-microsom.dtsi"
 #include "imx6qdl-cubox-i.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
index 39c2602fa87c..1709810de77e 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
@@ -42,6 +42,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
+#include "imx6qdl-microsom.dtsi"
 #include "imx6qdl-hummingboard.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
index b68aa0e57f20..8f39682c33a9 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -41,6 +41,7 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
+#include "imx6qdl-microsom.dtsi"
 #include "imx6qdl-cubox-i.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6q-hummingboard.dts b/arch/arm/boot/dts/imx6q-hummingboard.dts
index 69a7a0a1cb21..6fc692940e6b 100644
--- a/arch/arm/boot/dts/imx6q-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6q-hummingboard.dts
@@ -42,6 +42,7 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
+#include "imx6qdl-microsom.dtsi"
 #include "imx6qdl-hummingboard.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 57ce2dbb6ad9..98ec7ce1f2a3 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -38,7 +38,6 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "imx6qdl-microsom.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index afd981e9b5e3..84e6392fee1f 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -38,7 +38,6 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "imx6qdl-microsom.dtsi"
 
 / {
 	chosen {
-- 
2.7.4
