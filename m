From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 20 Dec 2013 11:30:43 +0000
Subject: [PATCHv4 3/4] ARM: dts: Enable SAI ALSA SoC DAI device for
 Vybrid VF610 TOWER board.
In-Reply-To: <1387501387-2151-3-git-send-email-Li.Xiubo@freescale.com>
References: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
 <1387501387-2151-3-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <e130ad7ed4b64bc198d69762edbd8d4b@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  Could someone help review and merge this DTS patch please ?

  Thanks very much!

Best Regards,
Xiubo



> Subject: [PATCHv4 3/4] ARM: dts: Enable SAI ALSA SoC DAI device for Vybrid
> VF610 TOWER board.
> 
> This patch adds and enables the SAI device.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index c8047ca..e60c20c 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -74,6 +74,12 @@
>  	status = "okay";
>  };
> 
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2_1>;
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1_1>;
> --
> 1.8.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
