From: jerry.huang@nxp.com (Jerry Huang)
Date: Wed, 14 Dec 2016 09:44:20 +0000
Subject: [PATCH] arm/dts: ls1021a: Add dma-coherent property to usb3 node
In-Reply-To: <1479885324-5468-1-git-send-email-jerry.huang@nxp.com>
References: <1479885324-5468-1-git-send-email-jerry.huang@nxp.com>
Message-ID: <DB5PR0401MB181343CDD178798178F6AB01FE9A0@DB5PR0401MB1813.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Changming Huang [mailto:jerry.huang at nxp.com]
> Sent: Wednesday, November 23, 2016 3:15 PM
> To: robh+dt at kernel.org; mark.rutland at arm.com; linux at armlinux.org.uk
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Jerry Huang <jerry.huang@nxp.com>; Rajesh
> Bhagat <rajesh.bhagat@nxp.com>
> Subject: [PATCH] arm/dts: ls1021a: Add dma-coherent property to usb3 node
> 
> This sets dma ops as coherent for usb 3.0 platform device
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 368e219..81fb4d9 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -627,6 +627,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			dma-coherent;
>  		};
> 
>  		pcie at 3400000 {
> --
How about this property for usb? Any comment for it?
