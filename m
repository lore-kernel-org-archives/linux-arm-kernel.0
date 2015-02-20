From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 20 Feb 2015 15:42:03 +0200
Subject: [PATCH 2/5] ARM: DTS: omap3: Correct the dma controller's property
 names
In-Reply-To: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
References: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1424439726-31994-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the Documentation/devicetree/bindings/dma/dma.txt the
dma-channels and dma-requests property should not have '#'.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 01b71111bd55..f4f78c40b564 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -155,8 +155,8 @@
 				     <14>,
 				     <15>;
 			#dma-cells = <1>;
-			#dma-channels = <32>;
-			#dma-requests = <96>;
+			dma-channels = <32>;
+			dma-requests = <96>;
 		};
 
 		omap3_pmx_core: pinmux at 48002030 {
-- 
2.3.0
