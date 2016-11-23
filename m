From: jerry.huang@nxp.com (Changming Huang)
Date: Wed, 23 Nov 2016 15:15:24 +0800
Subject: [PATCH] arm/dts: ls1021a: Add dma-coherent property to usb3 node
Message-ID: <1479885324-5468-1-git-send-email-jerry.huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sets dma ops as coherent for usb 3.0 platform device

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 368e219..81fb4d9 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -627,6 +627,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			dma-coherent;
 		};
 
 		pcie at 3400000 {
-- 
1.7.9.5
