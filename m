From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 21 Dec 2017 05:14:51 +0000
Subject: [PATCH 2/2][v2] ARM: dts: ls1021aqds: Add nand node for ifc
 controller
In-Reply-To: <1512013344-4042-3-git-send-email-prabhakar.kushwaha@nxp.com>
References: <1512013344-4042-1-git-send-email-prabhakar.kushwaha@nxp.com>
 <1512013344-4042-3-git-send-email-prabhakar.kushwaha@nxp.com>
Message-ID: <HE1PR04MB124129FE73928FFDA66AFFAB970D0@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> -----Original Message-----
> From: Prabhakar Kushwaha [mailto:prabhakar.kushwaha at nxp.com]
> Sent: Thursday, November 30, 2017 9:12 AM
> To: devicetree at vger.kernel.org; robh at kernel.org; mark.rutland at arm.com;
> shawnguo at kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; Jagdish Gediya <jagdish.gediya@nxp.com>
> Subject: [PATCH 2/2][v2] ARM: dts: ls1021aqds: Add nand node for ifc controller
> 
> LS1021AQDS support NAND flash on IFC chip-select 2.
> 
> So add NAND node in device tree for IFC controller.
> 
> Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> ---
> Changes for v2: updated subject
> 
>  arch/arm/boot/dts/ls1021a-qds.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-
> qds.dts
> index 9408753..2b37d04 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -239,6 +239,11 @@
>  		device-width = <1>;
>  	};
> 
> +	nand at 2,0 {
> +		compatible = "fsl,ifc-nand";
> +		reg = <0x2 0x0 0x10000>;
> +	};
> +
>  	fpga: board-control at 3,0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> --


There are no review comments on this patch.

Can you please accept this patch

--pk
