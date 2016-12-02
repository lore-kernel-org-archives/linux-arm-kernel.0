From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri,  2 Dec 2016 10:08:43 +0100
Subject: [PATCH 5/5] ARM: dts: imx6qdl-sabrelite: remove hardcoded LVDS bus
 format
In-Reply-To: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
References: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
Message-ID: <20161202090843.22613-6-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bus format is therefore retrieved from the connected panel
information.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 1f9076e..452ae47 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -525,8 +525,6 @@
 	status = "okay";
 
 	lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
 		status = "okay";
 
 		port at 4 {
-- 
2.9.3
