From: cb@sgoc.de (Christoph G. Baumann)
Date: Wed, 17 Jul 2013 18:27:38 +0200
Subject: [PATCH v2 1/3] mxs: enable ocotp in device tree
In-Reply-To: <1374078460-4126-1-git-send-email-cb@sgoc.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
 <1374078460-4126-1-git-send-email-cb@sgoc.de>
Message-ID: <1374078460-4126-2-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <cb@sgoc.de>

Signed-off-by: "Christoph G. Baumann" <cb@sgoc.de>
---
 arch/arm/boot/dts/imx23.dtsi |    1 -
 arch/arm/boot/dts/imx28.dtsi |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 587ceef..dc70ea9 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -348,7 +348,6 @@
 			ocotp at 8002c000 {
 				compatible = "fsl,ocotp";
 				reg = <0x8002c000 0x2000>;
-				status = "disabled";
 			};
 
 			axi-ahb at 8002e000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 6a8acb0..968244a 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -748,7 +748,6 @@
 			ocotp at 8002c000 {
 				compatible = "fsl,ocotp";
 				reg = <0x8002c000 0x2000>;
-				status = "disabled";
 			};
 
 			axi-ahb at 8002e000 {
-- 
1.7.9.5
