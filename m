From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon,  3 Sep 2018 16:08:36 +0200
Subject: [PATCH v2 1/5] arm64: dts: fsl: use a generic node name for m25p80
 flashes
Message-ID: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a generic node name for the m25p80 flashes on ls1043 and ls1046 boards.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index c7b8d2c009cd..af972e91d6bc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -136,7 +136,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fl128s at 0 {
+	qflash0: flash at 0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index e69306e6b0b1..219068220b84 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -165,7 +165,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fl128s at 0 {
+	qflash0: flash at 0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 440e111651d5..df676b30357b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -103,7 +103,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fs512s at 0 {
+	qflash0: flash at 0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -111,7 +111,7 @@
 		reg = <0>;
 	};
 
-	qflash1: s25fs512s at 1 {
+	qflash1: flash at 1 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.19.0.rc1
