From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Tue, 28 Aug 2018 18:12:13 +0800
Subject: [PATCH v1] arm64: dts: ls1043a: Add configure-gfladj property to USB3
 node
Message-ID: <20180828101213.25750-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajesh Bhagat <rajesh.bhagat@freescale.com>

Add "configure-gfladj" boolean property to USB3 node. This property
is used to determine whether frame length adjustent is required or
not

Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index a830a2e..a3c5165 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -610,6 +610,7 @@
 			snps,dis-u1u2-when-u3-quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			dma-coherent;
+			configure-gfladj;
 		};
 
 		usb1: usb3 at 3000000 {
@@ -623,6 +624,7 @@
 			snps,dis-u1u2-when-u3-quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			dma-coherent;
+			configure-gfladj;
 		};
 
 		usb2: usb3 at 3100000 {
@@ -636,6 +638,7 @@
 			snps,dis-u1u2-when-u3-quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			dma-coherent;
+			configure-gfladj;
 		};
 
 		sata: sata at 3200000 {
-- 
1.7.1
