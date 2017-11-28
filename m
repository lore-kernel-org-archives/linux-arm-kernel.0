From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 28 Nov 2017 15:02:10 +0000
Subject: [PATCH v2 03/16] ARM: dts: imx6qdl-microsom: rename to imx6qdl-sr-som
In-Reply-To: <20171128150045.GV31757@n2100.armlinux.org.uk>
References: <20171128150045.GV31757@n2100.armlinux.org.uk>
Message-ID: <E1eJhOk-0006NH-8m@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon and myself feel that "imx6qdl-microsom" is too generic a name for
SolidRun's microsom - some other manufacturer could have their own
microsom.  Change the name to the shorter "imx6qdl-sr-som".

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6q-h100.dts                                 | 2 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi                           | 2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi                      | 2 +-
 arch/arm/boot/dts/{imx6qdl-microsom.dtsi => imx6qdl-sr-som.dtsi} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/boot/dts/{imx6qdl-microsom.dtsi => imx6qdl-sr-som.dtsi} (100%)

diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index bf5dfc9c8127..815e9437e3f0 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -42,7 +42,7 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
-#include "imx6qdl-microsom.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 
 / {
 	model = "Auvidea H100";
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 57ce2dbb6ad9..0bc1734d8bdf 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -38,7 +38,7 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "imx6qdl-microsom.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index afd981e9b5e3..246984992ad0 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -38,7 +38,7 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "imx6qdl-microsom.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm/boot/dts/imx6qdl-microsom.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6qdl-microsom.dtsi
rename to arch/arm/boot/dts/imx6qdl-sr-som.dtsi
-- 
2.7.4
