From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 11 Feb 2014 22:44:22 +0400
Subject: [PATCH] ARM: dts: imx27-phytec-phycard-s-som: Rename file to .dtsi
Message-ID: <1392144262-9839-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCA-100 module cannot be used standalone. This patch renames
module file to .dtsi and excludes it from compilation.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile                                              | 1 -
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts                        | 2 +-
 .../{imx27-phytec-phycard-s-som.dts => imx27-phytec-phycard-s-som.dtsi} | 0
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename arch/arm/boot/dts/{imx27-phytec-phycard-s-som.dts => imx27-phytec-phycard-s-som.dtsi} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 222fe15..48ee3ab 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -144,7 +144,6 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-apf27dev.dtb \
 	imx27-pdk.dtb \
 	imx27-phytec-phycore-rdk.dtb \
-	imx27-phytec-phycard-s-som.dtb \
 	imx27-phytec-phycard-s-rdk.dtb \
 	imx31-bug.dtb \
 	imx35-eukrea-mbimxsd35-baseboard.dtb \
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 1cd3a87..3c3964a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -9,7 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include "imx27-phytec-phycard-s-som.dts"
+#include "imx27-phytec-phycard-s-som.dtsi"
 
 / {
 	model = "Phytec pca100 rapid development kit";
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
rename to arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi
-- 
1.8.3.2
