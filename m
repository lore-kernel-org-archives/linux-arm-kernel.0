From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  6 May 2018 22:03:40 -0300
Subject: [PATCH 2/2] ARM: dts: imx28-duckbill-2-enocean: Remove unnecessary
 #address/#size-cells
In-Reply-To: <1525655020-31260-1-git-send-email-festevam@gmail.com>
References: <1525655020-31260-1-git-send-email-festevam@gmail.com>
Message-ID: <1525655020-31260-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warnings:

arch/arm/boot/dts/imx28-duckbill-2-enocean.dtb: Warning (avoid_unnecessary_addr_size): /gpio-keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" propert

Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
index 7f8d40a..2221533 100644
--- a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
+++ b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
@@ -206,8 +206,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&enocean_button>;
 
-- 
2.7.4
