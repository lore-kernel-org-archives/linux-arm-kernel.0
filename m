From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 30 Oct 2014 21:27:09 -0700
Subject: [PATCH 3/5] ARM: dts: imx: add cpu0 alias
In-Reply-To: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
References: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1414729631-11005-4-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an alias on the cpu0 node allows devicetree files to modify the
regulators for LDO-bypass mode.

Cc: devicetree at vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 +-
 arch/arm/boot/dts/imx6q.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index b453e0e..61e0047 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -17,7 +17,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e9f3646..5900761 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -21,7 +21,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
-- 
1.8.3.2
