From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 20 Feb 2015 15:42:02 +0200
Subject: [PATCH 1/5] ARM: DTS: omap2: Correct the dma controller's property
 names
In-Reply-To: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
References: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1424439726-31994-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the Documentation/devicetree/bindings/dma/dma.txt the
dma-channels and dma-requests property should not have '#'.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 59d1c297bb30..578fa2a54dce 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -87,8 +87,8 @@
 				     <14>,
 				     <15>;
 			#dma-cells = <1>;
-			#dma-channels = <32>;
-			#dma-requests = <64>;
+			dma-channels = <32>;
+			dma-requests = <64>;
 		};
 
 		i2c1: i2c at 48070000 {
-- 
2.3.0
