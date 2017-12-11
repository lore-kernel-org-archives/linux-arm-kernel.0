From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:57:32 +0000
Subject: [PATCH 03/20] ARM: dts: imx6qdl-hummingboard2: rename microsom include
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eOROW-0000Gw-LN@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename microsom include to imx6qdl-sr-som.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 72226ccf3e34..2dfd8f5887fc 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -38,7 +38,7 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "imx6qdl-microsom.dtsi"
+#include "imx6qdl-sr-som.dtsi"
 
 / {
 	chosen {
-- 
2.7.4
