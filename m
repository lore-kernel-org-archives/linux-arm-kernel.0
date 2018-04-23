From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Apr 2018 16:50:32 -0300
Subject: [PATCH 4/5] ARM: dts: imx6q-utilite-pro: Remove #address/#size-cells
 from encoder
In-Reply-To: <1524513033-21136-1-git-send-email-festevam@gmail.com>
References: <1524513033-21136-1-git-send-email-festevam@gmail.com>
Message-ID: <1524513033-21136-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warning:

arch/arm/boot/dts/imx6q-utilite-pro.dtb: Warning (avoid_unnecessary_addr_size): /encoder: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q-utilite-pro.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
index f5d9c34..d16ff20 100644
--- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
@@ -61,8 +61,6 @@
 
 	encoder {
 		compatible = "ti,tfp410";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.7.4
