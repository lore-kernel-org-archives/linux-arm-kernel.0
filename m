From: mhei@heimpold.de (Michael Heimpold)
Date: Thu, 27 Mar 2014 23:51:29 +0100
Subject: [PATCH v2 3/4] arm: mxs: dt: imx28: include gpio.h to allow use of
 symbolic names
In-Reply-To: <1395960690-19531-1-git-send-email-mhei@heimpold.de>
References: <1395960690-19531-1-git-send-email-mhei@heimpold.de>
Message-ID: <1395960690-19531-4-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
Changes since v1:
- new patch

 arch/arm/boot/dts/imx28.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 90a5795..a95cc53 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -9,6 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 #include "imx28-pinfunc.h"
 
-- 
1.7.10.4
