From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Apr 2018 16:50:33 -0300
Subject: [PATCH 5/5] ARM: dts: imx6q-var-dt6customboard: Remove
 #address/#size-cells from gpio-keys
In-Reply-To: <1524513033-21136-1-git-send-email-festevam@gmail.com>
References: <1524513033-21136-1-git-send-email-festevam@gmail.com>
Message-ID: <1524513033-21136-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warning:

arch/arm/boot/dts/imx6q-var-dt6customboard.dtb: Warning (avoid_unnecessary_addr_size): /gpio-keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
index e0728d4..f2368a0 100644
--- a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
+++ b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
@@ -26,8 +26,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		back {
-- 
2.7.4
