From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Fri, 26 Jan 2018 16:22:15 +0800
Subject: [PATCH v2] arm: dts: ls1021a: Add configure-gfladj property to USB3
 node
Message-ID: <20180126082215.3191-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yinbo.zhu <yinbo.zhu@nxp.com>

Add "configure-gfladj" boolean property to USB3 node. This property
is used to determine whether frame length adjustent is required
or not

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Honghua Yin <Hong-Hua.Yin@freescale.com>
Signed-off-by: yinbo zhu <yinbo.zhu@nxp.com>
---
Change in v2:
		Remove the automatic generated tag from Gerrit.
		Change "yinbo.zhu" to "yinbo zhu".
 arch/arm/boot/dts/ls1021a.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f..ae8fc40 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -681,6 +681,7 @@
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			configure-gfladj;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 		};
-- 
1.7.1
