From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 20 Dec 2013 11:30:33 +0000
Subject: [PATCHv4 2/4] ARM: dts: Add Freescale SAI ALSA SoC Digital
 Audio Interface node for VF610.
In-Reply-To: <1387501387-2151-2-git-send-email-Li.Xiubo@freescale.com>
References: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
 <1387501387-2151-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <96d8b47fd8c14c11a1cd12d5810177ca@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  Could someone help review and merge this DTS patch please ?

  Thanks very much!

Best Regards,
Xiubo



> Subject: [PATCHv4 2/4] ARM: dts: Add Freescale SAI ALSA SoC Digital Audio
> Interface node for VF610.
> 
> This patch adds the SAI's edma mux Tx and Rx support.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index e84d84c..2d6ddd0 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -166,6 +166,9 @@
>  				interrupts = <0 86 0x04>;
>  				clocks = <&clks VF610_CLK_SAI2>;
>  				clock-names = "sai";
> +				dma-names = "tx", "rx";
> +				dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
> +					<&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
>  				status = "disabled";
>  			};
> 
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
