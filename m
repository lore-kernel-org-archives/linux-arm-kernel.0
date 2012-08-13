From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:22 +0800
Subject: [PATCH 02/17] ARM: dts: imx6q: name iomuxc sub-nodes following pin
 function
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Name iomuxc sub-nodes following pin function and hardware manual.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 +-
 arch/arm/boot/dts/imx6q.dtsi          |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index ee5de8f..1a99257 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -98,7 +98,7 @@
 			uart2: serial at 021e8000 {
 				status = "okay";
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_serial2_1>;
+				pinctrl-0 = <&pinctrl_uart2_1>;
 			};
 
 			i2c at 021a0000 { /* I2C1 */
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index bd72a4f..a078436 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -550,8 +550,8 @@
 					};
 				};
 
-				serial2 {
-					pinctrl_serial2_1: serial2grp-1 {
+				uart2 {
+					pinctrl_uart2_1: uart2grp-1 {
 						fsl,pins = <
 							183 0x1b0b1	/* MX6Q_PAD_EIM_D26__UART2_TXD */
 							191 0x1b0b1	/* MX6Q_PAD_EIM_D27__UART2_RXD */
-- 
1.7.5.4
