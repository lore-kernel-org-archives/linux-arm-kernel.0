From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Sun, 3 Dec 2017 23:02:37 +0000
Subject: [PATCH 09/12] ARM: dts: imx6qdl-colibri: Remove unneeded reg
 property
In-Reply-To: <1512156285-18451-9-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
 <1512156285-18451-9-git-send-email-festevam@gmail.com>
Message-ID: <1512342155.21715.6.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-12-01 at 17:24 -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> As described in
> Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> there is no 'reg' property under stmpe_touchscreen, so remove it
> to fix the following build warning with W=1:
> 
> arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb: Warning
> (unit_address_vs_reg): Node /soc/aips-bus at 2100000/i2c at 21a4000/stmpe81
> 1 at 41/stmpe_touchscreen has a reg or ranges property, but no unit name
> 
> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index fc66bbf..e4eb300 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -274,7 +274,6 @@
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			reg = <0>;
>  			/* 3.25 MHz ADC clock speed */
>  			st,adc-freq = <1>;
>  			/* 8 sample average control */
