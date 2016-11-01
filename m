From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 1 Nov 2016 15:38:12 -0200
Subject: [PATCH] ARM: dts: imx6sx-udoo: Add board specific compatible strings
Message-ID: <1478021892-18344-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a compatible entry for the specific board versions.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts    | 2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts | 2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
index 0b88878..0c1fc1a 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
@@ -46,7 +46,7 @@
 
 / {
 	model = "UDOO Neo Basic";
-	compatible = "fsl,imx6sx";
+	compatible = "udoo,neobasic", "fsl,imx6sx";
 
 	memory {
 		reg = <0x80000000 0x20000000>;
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
index d6fdd17..5d6c227 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
@@ -46,7 +46,7 @@
 
 / {
 	model = "UDOO Neo Extended";
-	compatible = "fsl,imx6sx";
+	compatible = "udoo,neoextended", "fsl,imx6sx";
 
 	memory {
 		reg = <0x80000000 0x40000000>;
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
index d8c3577..653ceb2 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
@@ -46,7 +46,7 @@
 
 / {
 	model = "UDOO Neo Full";
-	compatible = "fsl,imx6sx";
+	compatible = "udoo,neofull", "fsl,imx6sx";
 
 	memory {
 		reg = <0x80000000 0x40000000>;
-- 
2.7.4
