From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:57:37 +0000
Subject: [PATCH 04/20] ARM: dts: imx6*-hummingboard2: move microsom includes
 into .dts
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eOROb-0000H4-P4@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the microsom includes into the .dts files.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6dl-hummingboard2.dts   | 1 +
 arch/arm/boot/dts/imx6q-hummingboard2.dts    | 1 +
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-hummingboard2.dts b/arch/arm/boot/dts/imx6dl-hummingboard2.dts
index 207ce329534a..30e042822ec6 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard2.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard2.dts
@@ -42,6 +42,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 #include "imx6qdl-hummingboard2.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6q-hummingboard2.dts b/arch/arm/boot/dts/imx6q-hummingboard2.dts
index b850111ddf34..8dcad5668c17 100644
--- a/arch/arm/boot/dts/imx6q-hummingboard2.dts
+++ b/arch/arm/boot/dts/imx6q-hummingboard2.dts
@@ -42,6 +42,7 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 #include "imx6qdl-hummingboard2.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 2dfd8f5887fc..676160ef2718 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -38,7 +38,6 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "imx6qdl-sr-som.dtsi"
 
 / {
 	chosen {
-- 
2.7.4
