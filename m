From: tharvey@gateworks.com (Tim Harvey)
Date: Fri,  6 Nov 2015 14:40:31 -0800
Subject: [PATCH 2/3] ARM: dts: imx: ventana: fix GW53xx/GW54xx lvds channel
In-Reply-To: <1446849632-20333-1-git-send-email-tharvey@gateworks.com>
References: <1446849632-20333-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1446849632-20333-3-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 7c51839..5172de0 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -247,7 +247,7 @@
 &ldb {
 	status = "okay";
 
-	lvds-channel at 1 {
+	lvds-channel at 0 {
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <18>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 743db9f..aad051b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -338,7 +338,7 @@
 &ldb {
 	status = "okay";
 
-	lvds-channel at 1 {
+	lvds-channel at 0 {
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <18>;
 		status = "okay";
-- 
1.9.1
