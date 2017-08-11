From: sriram.dash@nxp.com (Sriram Dash)
Date: Fri, 11 Aug 2017 17:56:25 +0000
Subject: [linux-devel] [PATCH 1/3] dts: usb3: Add configure-gfladj
 property	to USB3 nod
In-Reply-To: <1502443796-5255-1-git-send-email-yinbo.zhu@nxp.com>
References: <1502443796-5255-1-git-send-email-yinbo.zhu@nxp.com>
Message-ID: <AM3PR04MB12018E640B04B627D7890AF5F5890@AM3PR04MB1201.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: linux-devel-bounces@gforge.freescale.net [mailto:linux-devel-
>bounces at gforge.freescale.net] On Behalf Of yinbo.zhu at nxp.com
>Subject: [linux-devel] [PATCH 1/3] dts: usb3: Add configure-gfladj property to USB3
>nod
>
>From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>
>Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
>---
> arch/arm/boot/dts/ls1021a.dtsi | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi index
>ffbf3cf..f525297 100644
>--- a/arch/arm/boot/dts/ls1021a.dtsi
>+++ b/arch/arm/boot/dts/ls1021a.dtsi
>@@ -731,6 +731,8 @@
> 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> 			dr_mode = "host";
> 			snps,quirk-frame-length-adjustment = <0x20>;
>+			configure-gfladj;

I reckon the "configure-gfladj" is replaced with "snps,quirk-frame-length-adjustment"
in open source, which sets fladj reg value.
Please verify.

>+			dma-coherent;

> 			snps,dis_rxdet_inp3_quirk;
> 		};
>
>--
>2.1.0.27.g96db324
>
>_______________________________________________
>linux-devel mailing list
>linux-devel at gforge.freescale.net
>http://gforge.freescale.net/mailman/listinfo/linux-devel
