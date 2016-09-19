From: marex@denx.de (Marek Vasut)
Date: Mon, 19 Sep 2016 23:40:42 +0200
Subject: [PATCH 2/4] ARM: dts: mx5: Add new M53EVK manufacturer compat
In-Reply-To: <20160919214044.9615-1-marex@denx.de>
References: <20160919214044.9615-1-marex@denx.de>
Message-ID: <20160919214044.9615-2-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board is now manufactured by Aries Embedded GmbH, update compat string.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx53-m53.dtsi   | 4 ++--
 arch/arm/boot/dts/imx53-m53evk.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-m53.dtsi b/arch/arm/boot/dts/imx53-m53.dtsi
index d259f57..ec390aa5 100644
--- a/arch/arm/boot/dts/imx53-m53.dtsi
+++ b/arch/arm/boot/dts/imx53-m53.dtsi
@@ -12,8 +12,8 @@
 #include "imx53.dtsi"
 
 / {
-	model = "DENX M53";
-	compatible = "denx,imx53-m53", "fsl,imx53";
+	model = "Aries/DENX M53";
+	compatible = "aries,imx53-m53", "denx,imx53-m53", "fsl,imx53";
 
 	memory {
 		reg = <0x70000000 0x20000000>,
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index dcee1e0f..4347a32 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -13,8 +13,8 @@
 #include "imx53-m53.dtsi"
 
 / {
-	model = "DENX M53EVK";
-	compatible = "denx,imx53-m53evk", "fsl,imx53";
+	model = "Aries/DENX M53EVK";
+	compatible = "aries,imx53-m53evk", "denx,imx53-m53evk", "fsl,imx53";
 
 	display1: display at di1 {
 		compatible = "fsl,imx-parallel-display";
-- 
2.9.3
