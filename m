From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Mon, 22 Jan 2018 16:44:23 +0800
Subject: [PATCH v1] arm: dts: ls1021a: Add configure-gfladj property to USB3
 node
Message-ID: <20180122084423.10340-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yinbo.zhu <yinbo.zhu@nxp.com>

Add "configure-gfladj" boolean property to USB3 node. This property
is used to determine whether frame length adjustent is required
or not

Signed-off-by: Review Code-CDREVIEW <CDREVIEW@freescale.com>
Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Honghua Yin <Hong-Hua.Yin@freescale.com>
Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index f81fad2..a5ccf7a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -707,6 +707,7 @@
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			configure-gfladj;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 		};
-- 
1.7.1
