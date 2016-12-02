From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri,  2 Dec 2016 10:08:40 +0100
Subject: [PATCH 2/5] ARM: dts: imx6qdl-nitrogen6_max: remove hardcoded LVDS
 bus format
In-Reply-To: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
References: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
Message-ID: <20161202090843.22613-3-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bus format is therefore retrieved from the connected panel
information.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 34887a1..c43c36e 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -739,8 +739,6 @@
 	status = "okay";
 
 	lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
 		status = "okay";
 
 		port at 4 {
@@ -753,8 +751,6 @@
 	};
 
 	lvds-channel at 1 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
 		status = "okay";
 
 		port at 4 {
-- 
2.9.3
