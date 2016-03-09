From: yao.yuan@nxp.com (Yao Yuan)
Date: Wed, 9 Mar 2016 03:43:57 +0000
Subject: [PATCH 2/2] dts/ls2080a: Update DSPI compatible
In-Reply-To: <1457425377-6383-2-git-send-email-yao.yuan@freescale.com>
References: <1457425377-6383-1-git-send-email-yao.yuan@freescale.com>
 <1457425377-6383-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <AM2PR04MB07224122C47B72BD60A8E6B889B30@AM2PR04MB0722.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Sorry for the patch:
dts/ls2080a: Update DSPI compatible

I was just trying to resend this patch:
dts/ls2080a: update the DTS for QSPI and DSPI support
https://patchwork.ozlabs.org/patch/573108/

But I have a big mistake to sending a wrong patch.
Please ignore it.

And I will resend the right patch.

Sorry for make you confused.

Best Regards,
Yuan Yao


> -----Original Message-----
> From: Yuan Yao [mailto:yao.yuan at freescale.com]
> Sent: Tuesday, March 08, 2016 4:23 PM
> To: robh+dt at kernel.org; mark.rutland at arm.com; pawel.moll at arm.com
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Yao Yuan <yao.yuan@nxp.com>
> Subject: [PATCH 2/2] dts/ls2080a: Update DSPI compatible
> 
> From: Yuan Yao <yao.yuan@nxp.com>
> 
> The patch adds LS2085a to DSPI compatible.
> The DSPI driver on LS2080A should use TCFQ mode.
> It's different from on vf610.
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index 9d746c6..122c517 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -318,7 +318,7 @@
> 
>  		dspi: dspi at 2100000 {
>  			status = "disabled";
> -			compatible = "fsl,vf610-dspi";
> +			compatible = "fsl,ls2080a-dspi", "fsl,ls2085a-dspi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x2100000 0x0 0x10000>;
> --
> 2.1.0.27.g96db324
