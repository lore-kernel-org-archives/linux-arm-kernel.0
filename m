From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri,  2 Dec 2016 10:08:42 +0100
Subject: [PATCH 4/5] ARM: dts: imx6qdl-nitrogen6x: remove hardcoded LVDS bus
 format
In-Reply-To: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
References: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
Message-ID: <20161202090843.22613-5-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bus format is therefore retrieved from the connected panel
information.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 26d0604..16b14bd 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -579,8 +579,6 @@
 	status = "okay";
 
 	lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
 		status = "okay";
 
 		port at 4 {
-- 
2.9.3
