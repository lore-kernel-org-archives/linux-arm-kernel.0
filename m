From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 13 May 2014 13:30:31 +0300
Subject: [PATCH v2 4/5] ARM: dts: am33xx: Remove obsolete properties from edma
 node
In-Reply-To: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1399977032-26469-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma-channels, ti,edma-regions and ti,edma-slots no longer needed in DT since
the the same information is available in the IP's CCCFG register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index baf56cc92040..5e8f647ee4ec 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -147,9 +147,6 @@
 				<0x44e10f90 0x10>;
 			interrupts = <12 13 14>;
 			#dma-cells = <1>;
-			dma-channels = <64>;
-			ti,edma-regions = <4>;
-			ti,edma-slots = <256>;
 		};
 
 		gpio0: gpio at 44e07000 {
-- 
1.9.3
