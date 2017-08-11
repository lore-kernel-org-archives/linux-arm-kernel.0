From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Fri, 11 Aug 2017 17:29:54 +0800
Subject: [PATCH 1/3] dts: usb3: Add configure-gfladj property to USB3 nod
Message-ID: <1502443796-5255-1-git-send-email-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index ffbf3cf..f525297 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -731,6 +731,8 @@
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			configure-gfladj;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 		};
 
-- 
2.1.0.27.g96db324
