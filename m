From: marex@denx.de (Marek Vasut)
Date: Mon, 19 Sep 2016 23:40:41 +0200
Subject: [PATCH 1/4] ARM: dts: mxs: Add new M28EVK manufacturer compat
Message-ID: <20160919214044.9615-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board is now manufactured by Aries Embedded GmbH, update compat string.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx28-m28.dtsi   | 4 ++--
 arch/arm/boot/dts/imx28-m28evk.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 214bb15..a69856e 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -12,8 +12,8 @@
 #include "imx28.dtsi"
 
 / {
-	model = "DENX M28";
-	compatible = "denx,m28", "fsl,imx28";
+	model = "Aries/DENX M28";
+	compatible = "aries,m28", "denx,m28", "fsl,imx28";
 
 	memory {
 		reg = <0x40000000 0x08000000>;
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 8d04e57..dbfb8aa 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -13,8 +13,8 @@
 #include "imx28-m28.dtsi"
 
 / {
-	model = "DENX M28EVK";
-	compatible = "denx,m28evk", "fsl,imx28";
+	model = "Aries/DENX M28EVK";
+	compatible = "aries,m28evk", "denx,m28evk", "fsl,imx28";
 
 	apb at 80000000 {
 		apbh at 80000000 {
-- 
2.9.3
