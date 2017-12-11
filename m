From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:57:27 +0000
Subject: [PATCH 02/20] ARM: dts: imx6*-hummingboard2: remove ar8035 include
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eOROR-0000Go-Gp@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the AR8035 include, the file is now gone.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 0e3c57b99904..72226ccf3e34 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -39,7 +39,6 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 #include "imx6qdl-microsom.dtsi"
-#include "imx6qdl-microsom-ar8035.dtsi"
 
 / {
 	chosen {
-- 
2.7.4
