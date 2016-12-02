From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri,  2 Dec 2016 10:08:41 +0100
Subject: [PATCH 3/5] ARM: dts: imx6qdl-nitrogen6_som2: remove hardcoded LVDS
 bus format
In-Reply-To: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
References: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
Message-ID: <20161202090843.22613-4-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bus format is therefore retrieved from the connected panel
information.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index d80f21a..0521986 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -640,8 +640,6 @@
 	status = "okay";
 
 	lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
 		status = "okay";
 
 		port at 4 {
-- 
2.9.3
