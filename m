From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 21 Dec 2017 05:14:36 +0000
Subject: [PATCH 1/2][v2] ARM: dts: Add big-endian for IFC on LS1021A
In-Reply-To: <1512013344-4042-2-git-send-email-prabhakar.kushwaha@nxp.com>
References: <1512013344-4042-1-git-send-email-prabhakar.kushwaha@nxp.com>
 <1512013344-4042-2-git-send-email-prabhakar.kushwaha@nxp.com>
Message-ID: <HE1PR04MB1241E7538E97597B76606FF4970D0@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> -----Original Message-----
> From: Prabhakar Kushwaha [mailto:prabhakar.kushwaha at nxp.com]
> Sent: Thursday, November 30, 2017 9:12 AM
> To: devicetree at vger.kernel.org; robh at kernel.org; mark.rutland at arm.com;
> shawnguo at kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Jagdish Gediya
> <jagdish.gediya@nxp.com>; Alison Wang <alison.wang@nxp.com>; Prabhakar
> Kushwaha <prabhakar.kushwaha@nxp.com>
> Subject: [PATCH 1/2][v2] ARM: dts: Add big-endian for IFC on LS1021A
> 
> From: Jagdish Gediya <jagdish.gediya@nxp.com>
> 
> For the patch to update struct map_info's swap field based on device
> characteristics defined in device tree, big-endian parameter is added
> for LS1021A.
> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> ---
> Changes for v2: updated subject
> 
>  arch/arm/boot/dts/ls1021a.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 9319e1f..babb086 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -145,6 +145,7 @@
>  		ifc: ifc at 1530000 {
>  			compatible = "fsl,ifc", "simple-bus";
>  			reg = <0x0 0x1530000 0x0 0x10000>;
> +			big-endian;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> 
> --
> 1.9.1

There are no review comments on this patch.

Can you please accept this patch

--pk
