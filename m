From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 26 Sep 2018 14:33:46 +0000
Subject: [PATCh v3 4/4] MAINTAINERS: add i.MX8 DT path to i.MX architecture
In-Reply-To: <20180921125626.21971-4-l.stach@pengutronix.de>
References: <20180921125626.21971-1-l.stach@pengutronix.de>
 <20180921125626.21971-4-l.stach@pengutronix.de>
Message-ID: <AM0PR04MB42112E5BED8499DE590C232F80150@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lucas Stach [mailto:l.stach at pengutronix.de]
> Sent: Friday, September 21, 2018 8:56 PM
> To: Shawn Guo <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> patchwork-lst at pengutronix.de; Abel Vesa <abel.vesa@nxp.com>
> Subject: [PATCh v3 4/4] MAINTAINERS: add i.MX8 DT path to i.MX architecture
> 
> Shawn agreed to take patches for the i.MX8 parts through his tree.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b25905..f080df859941 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1461,6 +1461,7 @@ F:	arch/arm/mach-imx/
>  F:	arch/arm/mach-mxs/
>  F:	arch/arm/boot/dts/imx*
>  F:	arch/arm/configs/imx*_defconfig
> +F:	arch/arm64/boot/dts/freescale/imx*

This means other mx8 devices also need naming like this.
e.g. imx8qxp/qm_xxx.dts
Then we have
Imx*.dts for IMX series.
And fsl-*.dts for layerscape series.

It's fine to me. I will change qxp patch set as well later.
So:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

>  F:	drivers/clk/imx/
>  F:	drivers/soc/imx/
>  F:	include/soc/imx/
> --
> 2.19.0
